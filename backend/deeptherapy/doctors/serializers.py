from click import style
from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator
from .models import Quote, Question, Report, Patient, Doctor, User
from rest_framework.authtoken.models import Token

class UserSerializer(serializers.ModelSerializer):

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        return user

#check with serializers, it's missing the boolean value. Not sure where to put it?
    class Meta:
        model = User
        
        fields = (
            'username',
            'first_name',
            'last_name',
            'email',
            'is_patient',
            'is_doctor',
            "phone"
        )

        validators = [
            UniqueTogetherValidator(
                queryset=User.objects.all(),
                fields=['username', 'email']
            )
        ]

class doctorSerializer(serializers.ModelSerializer):
    
    # password2 = serializers.CharField(style={'input_type':'password'}, write_only = True)
    
    title = serializers.CharField()
    p_list = serializers.CharField(required = False)
    class Meta:
        model = User    
        fields = (
        'username',
        'email',
        "password",
        "country",
        # "user.password2",
        "phone",
        # 'dname',
        # 'demail',
        # 'dpass',
        'title',
        'p_list'
    )

    #16:06 part 1 new 22:46
    # https://www.youtube.com/watch?v=7TQufn2wCLc
        extra_kawrgs = {'password':{'write_only': True},}
    
    def save(self, **kwargs):
        user = User(username=self.validated_data['username'],
        email = self.validated_data['email'],phone = self.validated_data['phone'])
        password=self.validated_data['password']
        # password2 = self.validated_data['password2']
        # if password != password2:
            # raise serializers.ValidationError({'Error':"Password does not match"})
        user.set_password(password)
        user.is_doctor = True
        user.save()
        Doctor.objects.create(user = user)
        return user
##Okay, creation is possible, now have to proceed with the encryption/decryption and get to flutter
##You can grab all the related fields by using .modelnamelowercase_set.all() INSANE
class patientSerializer(serializers.ModelSerializer):
    
    pclass = serializers.CharField(allow_blank = True)
    doctor = serializers.CharField(allow_blank = True)
    class Meta:
        model = User    
        fields = (
        'username',
        'email',
        "password",
        "phone",
        "country"
        # 'dname',
        # 'demail',
        # 'dpass',
       'pclass',
        'doctor'
    )

    #16:06 part 1 new 22:46
    # https://www.youtube.com/watch?v=7TQufn2wCLc
        extra_kawrgs = {'password':{'write_only': True},}
    
    def save(self, **kwargs):
        
        try:
            print(self.validated_data)
            print(self.initial_data)
            
        
            t = self.initial_data['token']
            user = Token.objects.get(key = t).user
            user.username = self.data['username']
            # user.password = self.validated_data['password']
            user.email = self.validated_data['email']
            # user.phone 
            user.phone = self.validated_data['phone']
            password=self.validated_data['password']
            user.set_password(password)
            user.save()
            
        except Exception as e:
            print(e)
            user = User(username=self.validated_data['username'], email = self.validated_data['email'],
            phone = self.validated_data['phone'])
            password=self.validated_data['password']
            doctor = Doctor.objects.get(user = User.objects.get(username = self.validated_data['doctor']))
            # password2 = self.validated_data['password2']
            # if password != password2:
            #     raise serializers.ValidationError({'Error':"Password does not match"})
            user.set_password(password)
            user.is_patient = True
            user.save()
            Patient.objects.create(user = user, doctor=doctor)
        
        return user


class quoteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Quote
        fields = (
            'qid',
            'text',
            'q_class',
        )
     
# class patientSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Patient
#         fields = (
#         'pclass',
#         'plink',
#         'user',
#         # 'pname',
#         # 'pemail',
#         # 'ppass',
#         'pphone',
#         'pdoctor')

class questionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Question
        fields = (
            'cat',
            'qid',
            'options','question', 'is_multiple_choice', 'is_paragraph', 'is_slider')

class reportSerializer(serializers.ModelSerializer):    
    class Meta:
        model = Report

        fields = (
            'count',
            'link_id',
            'date','progress', 'depression', 'anxiety', 'activities', 'family_issues')
