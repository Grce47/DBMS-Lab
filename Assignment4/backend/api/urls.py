from django.urls import path
from .views import getinfo, list_patients, add_patient, delete_patient, add_prescription, admit_patient

urlpatterns = [
    path('getinfo/', getinfo),
    path('list_patient/', list_patients),
    path('add_patient/', add_patient),
    path('delete_patient/', delete_patient),
    path('add_prescription/', add_prescription),
    path('admit_patient/', admit_patient)
]