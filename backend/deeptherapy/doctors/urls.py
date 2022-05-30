from django.urls import path
from .views import UserRecordView, ListQuote, create_questions, create_quotes, PatientSignupView,ListQuestion, ReportView, GenerateCode, DoctorSignupView

app_name = 'doctors'
urlpatterns = [
    path('user/', UserRecordView.as_view(), name='users'),
    path('quote/', ListQuote.as_view(), name="quotes"),
    path('question/', ListQuestion.as_view(), name="questions"),
    path('add_questions/', create_questions, name='init_q'),
    path('add_quotes/', create_quotes, name='init'),
    path('report/', ReportView.as_view(), name="report"),
    path('add_patient/', PatientSignupView.as_view(), name="patient"),
    path('add_doctor/', DoctorSignupView.as_view(), name="doctor"),
    path('generate_code/', GenerateCode.as_view(), name="code")
    ]