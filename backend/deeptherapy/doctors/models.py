from email.policy import default
from click import password_option
from django.db import models
from django.forms import HiddenInput
from django import forms
from django.utils.translation import gettext as _
from django.contrib.postgres.fields import ArrayField
from django.contrib.auth.models import AbstractUser
from django.conf import settings
from django.dispatch import receiver
from rest_framework.authtoken.models import Token

class User(AbstractUser):
    
    is_patient = models.BooleanField(default=False)
    is_doctor = models.BooleanField(default=False)
    phone = models.CharField(max_length=50)
    country = models.CharField(max_length=30)

    def __str__(self):
        return self.username

@receiver(models.signals.post_save, sender = settings.AUTH_USER_MODEL)

def create_auth_token(sender, instance = None, created = False, **kwrgs):
    if created:
        Token.objects.create(user = instance)

# Create your models here.
class Doctor(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    ChPsychologist = 'Chartered Psychologist'
    ClPsychologist = 'Clinical Psychologist'
    CoPsychologist = 'Counselling Psychologist'
    Counselor_Psychotherapist = "Counselors/Psychotherapeutic Counsellor/ Psychotherapist"
    psy = "Psychiatrist"
    psychoanalist = "Psychoanalyst"
    psychologist = "Psychologist"

    CLASS = [
        (ChPsychologist,_(ChPsychologist)),
        (ClPsychologist,_(ClPsychologist)),
        (CoPsychologist,_(CoPsychologist)),
        (Counselor_Psychotherapist,_(Counselor_Psychotherapist)),
        (psy,_(psy)),
        (psychoanalist,_(psychoanalist)),
        (psychologist,_(psychologist))
    ]
    # dname = models.CharField(max_length=100) #contains first name + middle name(optional) + last name
    # demail = models.EmailField() 
    # dpass = forms.CharField(max_length=20, widget = forms.PasswordInput)
    
    
    title = models.CharField(max_length=100, choices = CLASS, default= Counselor_Psychotherapist) #Will add by selection, if doesn't exist he can type his own title
    p_list = ArrayField(models.CharField(max_length=100), default=list, blank=True)
    def __str__(self):
        return f"{self.user.username} {self.title}"
    class Meta:
        db_table = "doctors"

class Patient(models.Model):
    
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True, )
    DEPRESSION = 'Depression'
    ANXIETY = 'Anxiety'
    FAMILY = 'Family issues'
    CLASS = [
        (DEPRESSION, _('Depression')),
        (ANXIETY,_('Anxiety')),
        (FAMILY, _('Family issues'))
    ]

    #What if we remove generated codes and swap them with encoded tokens, which then will be verified inside the Tokens authentication part.
    #Break point: can you parse Tokens and check if one matches?
    #create user patient, with generated username and password, give encrypted token, recieving encyrpted token, decrypting it, if found, access profile and fill information, username, password, etc.. as update.
    # link = models.CharField(max_length=100)
    
    pclass = models.CharField(max_length = 20, choices= CLASS )
    # pname = models.CharField(max_length=100, blank=True) #contains first name + middle name(optional) + last name
    # pemail = models.EmailField(blank = True) 
    # ppass = forms.CharField(max_length=20, widget = forms.PasswordInput,required=False)
    #ForeignKey.limit_choices_to 
    #What's wrong? 
    
    doctor = models.ForeignKey(Doctor, on_delete=models.CASCADE)


    class Meta:
        db_table = "patients"


class Question(models.Model):

    qid = models.AutoField( primary_key= True)
    cat = models.TextField(null=False)
    question = models.TextField(null=False)
    options = ArrayField(models.CharField(max_length=20), default=list)
    
    is_multiple_choice = models.IntegerField()
    is_paragraph = models.IntegerField()
    is_slider = models.IntegerField()
    def __str__(self):
        return f'{self.qid} {self.cat}'

    class Meta:
        db_table = "questions"
#steps left for quiz to be fully done: 
#1-fix db
#2-deploy heroku test postman
#3-change connection and test

#Next step  ? Add doctor, create gen code function and save to paitnet, check if heroku also doesn't show form vars.
#adding patient with generated code is done, need to change the .forms ones though it's not as models. It's doesn't show on the db, etc...
#Next step? Authenticating everything doctors, patients and making it functional through the flutter side.
class Quote(models.Model):
    
    DEPRESSION = 'Depression'
    ANXIETY = 'Anxiety'
    FAMILY = 'Family issues'
    CLASS = [
        (DEPRESSION, _('Depression')),
        (ANXIETY,_('Anxiety')),
        (FAMILY, _('Family issues'))
    ]
    qid = models.AutoField( primary_key= True)
    text = models.TextField(null=False)
    q_class = models.CharField(null=False, max_length=20, choices=CLASS)
    

    def __str__(self):
        return f"{self.qid} {self.q_class}"
    class Meta:
        db_table = "quotes"


class Report(models.Model):

    count = models.IntegerField(null = False) # Should be incrementing from mobile app side
    link_id = models.TextField(null=False)
    date = models.DateTimeField(null = False) #using date of creation now
    progress = models.FloatField(null = False)
    depression = models.FloatField(default=0)
    anxiety = models.FloatField(default = 0)
    family_issues = models.FloatField(default = 0)
    patient = models.ForeignKey(Patient, on_delete=models.CASCADE)
    #Should add added_notes
    activities = ArrayField(models.CharField(max_length=20), default=list)


    def __str__(self):
        return f"Report {self.link_id} n°{self.number}"
    
    class Meta:
        db_table = "reports"
    
