"""deeptherapy URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from rest_framework.authtoken import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('doctors.urls', namespace='api')),
    path('api-token-auth/', views.obtain_auth_token, name='api-token-auth'),
    
]



# Future TO-DO
# IN VIEWS
# from rest_framework.authtoken.views import ObtainAuthToken
# from rest_framework.authtoken.models import Token
# from rest_framework.response import Response

# class CustomAuthToken(ObtainAuthToken):

#     def post(self, request, *args, **kwargs):
#         serializer = self.serializer_class(data=request.data,
#                                        context={'request': request})
#         serializer.is_valid(raise_exception=True)
#         user = serializer.validated_data['user']
#         token, created = Token.objects.get_or_create(user=user)
#         return Response({
#             'token': token.key,
#             'user_id': user.pk,
#             'email': user.email
#         })
#editing authtoken to validate, if he's a doctor or patient
#next is, calling the function and accessing the account
#Next is, finishing video on the login not just signup(it's probably easier)
#Next is, getting all the logical things to work(account doesn't exist, etc...)
#Next is, creating the necessary api functions for signup
#assuring you have variables across all screens.
#for the doctor you'll need his username when adding patient.