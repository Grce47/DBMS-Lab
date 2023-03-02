from django.db import models

class Patient(models.Model):
    def __str__(self):
        return self.name
    name = models.CharField(max_length=50, default='None')
    address = models.CharField(max_length=50, default='None')
    phone = models.CharField(max_length=50, default='None')
    age = models.CharField(max_length=50, default='None')
    symptoms = models.CharField(max_length=50, default='None')