from django.urls import path
from doctors.views import getRoutes

urlpatterns = [
    path('',getRoutes),
]