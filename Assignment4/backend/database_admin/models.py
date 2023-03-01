from django.db import models

class Patient(models.Model):
   def __str__(self):
       return self.name
  
   name = models.CharField(max_length=50)
   age = models.IntegerField()
   phone_number = models.CharField(max_length=50)
   symptoms = models.CharField(max_length=100)