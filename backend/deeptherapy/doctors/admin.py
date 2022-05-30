from django.contrib import admin

from .models import Doctor, Quote, Question, Report, Patient, User

# Register your models here.
admin.site.register(User)
admin.site.register(Doctor)
admin.site.register(Quote)
admin.site.register(Question)
admin.site.register(Report)
admin.site.register(Patient)