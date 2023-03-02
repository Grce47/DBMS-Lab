from django.urls import path
from .views import getinfo, list_patients, add_patient

urlpatterns = [
    path('getinfo/', getinfo),
    path('list_patient/', list_patients),
    path('add_patient/', add_patient)
]