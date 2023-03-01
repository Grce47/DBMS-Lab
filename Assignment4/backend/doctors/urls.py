from django.urls import path
from .views import getAllPatient


urlpatterns = [
   path('', getAllPatient),
]
