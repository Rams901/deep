import json
from unittest import result
from django.http import HttpResponse
from .serializers import UserSerializer, reportSerializer, patientSerializer, quoteSerializer, questionSerializer, doctorSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAdminUser
from rest_framework.authtoken.models import Token
import datetime
from rest_framework import generics
from . import models
from .add_elements import initiate_all, initiate_all_q
from django.db.utils import OperationalError
from .ai_script import generate_results
import uuid

#Creating a user model with boolean values for is_patient, is_doctor. In order, to add extra information specific to role, 
# we have to create profile models that have oneToOne relationship with the user.
#conerning the patient, first time logging in is not actually authentication but rather accessing the create profile. Just using the generated token 
# and then filling all the information which lead to actual profile creation.

#Follow up where you're at: https://github.com/sibtc/django-multiple-user-types-example https://simpleisbetterthancomplex.com/tutorial/2018/01/18/how-to-implement-multiple-user-types-with-django.html
#Now the difference he's working on web not rest api, so no serializers used. 
# I have to focus on what he's doing on the form and try to make it compatible as api, and make sure to create auth token once profile saved.
#Makemigrations for doctor full signup is nearly ready, need to find a way to pass in a whole user object as default. 25:30
#For the patient, since there is a code generation, there should be also a generated username and password that can be optionally changed by the patient.
class DoctorSignupView(generics.GenericAPIView):
    
    serializer_class = doctorSerializer

    def post(self, request, *args, **kwargs):
        print(request.data)
        print(self)
        serializer = self.get_serializer(data = request.data)
        serializer.is_valid(raise_exception = True)
        user = serializer.save()
        return Response(
            {
                "user": UserSerializer(user, context=self.get_serializer_context()).data
                ,"token":Token.objects.get(user=user).key,
                "message":"account created succesffuly"      
            }
        )

class PatientSignupView(generics.GenericAPIView):
    
    serializer_class = patientSerializer

    def post(self, request, *args, **kwargs):
        print(request.data)

        print(self)
        serializer = self.get_serializer(data = request.data)
        serializer.is_valid(raise_exception = True)
        user = serializer.save()
        return Response(
            {
                "user": UserSerializer(user, context=self.get_serializer_context()).data
                ,"token":Token.objects.get(user=user).key,
                "message":"account created succesffuly"      
            }
        )
    
class UserRecordView(APIView):
    """
    API View to create or get a list of all the registered
    users. GET request returns the registered users whereas
    a POST request allows to create a new user.
    """
    permission_classes = [IsAdminUser]

    def get(self, format=None):
        users = models.User.objects.all()
        serializer = UserSerializer(users, many=True)
        return Response(serializer.data)

    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid(raise_exception=ValueError):
            
            serializer.create(validated_data=request.data)

            return Response(
                serializer.data,
                status=status.HTTP_201_CREATED
            )
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )
#Next step, encode token and send it as the response to the generate code, when receiving a post, check the auth token, if exists, update that user. 

class GenerateCode(generics.GenericAPIView):
    def post(self, request):
        result_data = generate_code(request.data)
        print(result_data)
        serializer = patientSerializer(data = result_data)
        serializer.is_valid(raise_exception = True)
        user = serializer.save()
        
        return Response(
            {
                "user": UserSerializer(user, context=self.get_serializer_context()).data
                ,"token":Token.objects.get(user=user).key,
                "message":"account created succesffuly"      
            })
       
        # return Response(
        #     {
        #         "error": True,
        #         "error_msg": serializer.error_messages,
        #     },
        #     status=status.HTTP_400_BAD_REQUEST
        # )

class ReportView(APIView):
    # It's not working for some reason. Getting bad request. check serializers, check potential errors. Fix it, inchallah.
    permission_classes = [IsAdminUser]
    def post(self, request):
        result_data = generate_results(request.data)
        print(result_data)
        serializer = reportSerializer(data = result_data)
        
        if serializer.is_valid(raise_exception=ValueError):
            print("valid")
            serializer.create(validated_data=result_data)
            return Response(serializer.data, status = status.HTTP_201_CREATED)
        return Response(
            {
                "error": True,
                "error_msg": serializer.error_messages,
            },
            status=status.HTTP_400_BAD_REQUEST
        )

class ListQuote(generics.ListCreateAPIView):
    queryset = models.Quote.objects.all()
    serializer_class = quoteSerializer
    
    def get(self, format=None):
       
        # print( self.request.body, self.request.headers)

        q_class, quota = self.request.headers['Q-Class'], int(self.request.headers['Quota'])
        
        quotes = models.Quote.objects.all()
        quotes = filter(lambda x: x.q_class == q_class, quotes)
        print(quotes)
        
        try:
            quotes = quotes[quota]
        except:
            pass
        serializer = quoteSerializer(quotes, many=True)
        return Response(serializer.data)

#Steps to add patient to doctor: generate code and blank patient profile with username, password generated, added to doctor as well, 
# flutter part would check if code exists. If yes, the get response will directly open the fill information page,(the user doesn't need to know there is a generated usename or password, since they both will change)
# the patient creates his profile by filling the info, will get updated in the doctor part aswell.
#Break point: using oneToManyField for doctor, but how to access that doctor
#patient = Patient.objects.get(gen_code).
# Token.objects.filter(key ="1f1bf307ae51363faa8338bc7c887aa5af96337a" ).exists()

class DetailsQuote(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Quote.objects.all()
    serializer_class = quoteSerializer

class DetailsQuestion(generics.RetrieveUpdateDestroyAPIView):
    queryset = models.Question.objects.all()
    serializer_class = questionSerializer

class ListQuestion(generics.ListCreateAPIView):
    try: 
        queryset = models.Question.objects.all()
        serializer_class = questionSerializer
    except OperationalError:
        pass

        def get(self, format=None):
        
            # print( self.request.body, self.request.headers)

            cat = self.request.headers['cat']
            
            try: 
                questions = models.Question.objects.all()
                questions = filter(lambda x: x.cat == cat, questions)
                
                print("###",len(questions))
            except OperationalError:
                print("hi")
                return
            
                #Based on level will be chosen the questions.
                #For example:
                #level = 1
                #questions[0:9] chosen.
            questions = questions
            
            serializer = questionSerializer(questions, many=True)
            return Response(serializer.data)


def generate_code(data):
    #data = {'pclass': 'Depression', 'pdoctor':001}
    print(data)
    print(data['doctor'])
    # plink = ''.join([str(ord(car)) for car in ascii(data['pdoctor'] + data['pclass'] + str(datetime.datetime.now()))])
    username = uuid.uuid4().hex[:10]
    password = uuid.uuid1().hex[:15]
    patient_data = {'pclass':data['pclass'],'doctor':data['doctor'], 'username':username, 'password': password, "country": "", "email":"","phone":"1"}
    return patient_data

def create_quotes(*kwargs):
    initiate_all()
    return HttpResponse('Done')

def create_questions(*kwargs):
    try:
        initiate_all_q()
        
        return HttpResponse("Q Done.")
    except Exception as e:
        print(e)
        pass
def encode(t):
    return "".join([ord(x) for x in str(t)])
def decode(t):
    return "".join([ascii(x) for x in str(t)])

def to_json(questions):
    for question in questions:
        question['options'] = json.loads(question['options'])
    return questions