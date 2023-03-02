from django.db import models

class Patient(models.Model):
    def __str__(self):
        return self.name
    name = models.CharField(max_length=50, default=None)
    address = models.CharField(max_length=50, default=None)
    phone = models.CharField(max_length=50, default=None)
    age = models.CharField(max_length=50, default=None)
    symptoms = models.CharField(max_length=50, default=None)
    prescription = models.CharField(max_length=50, default=None)
    
class Room(models.Model): 
    def __str__(self):
        return str(self.number)
    number = models.IntegerField(default=0)
    patient = models.OneToOneField(Patient, on_delete=models.SET_NULL, null=True, blank=True)