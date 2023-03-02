from django.contrib import admin
from .models import Patient, Room

admin.site.register(Patient)
admin.site.register(Room)