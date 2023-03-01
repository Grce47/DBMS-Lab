from django.urls import path
from .views import getinfo

urlpatterns = [
    path('getinfo/',getinfo)
]