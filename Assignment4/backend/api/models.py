from django.db import models
from django.contrib.auth.models import User


class Patient(models.Model):
    def __str__(self):
        return self.name
    name = models.CharField(max_length=50, default=None)
    address = models.CharField(max_length=50, default=None)
    phone = models.CharField(max_length=50, default=None)
    age = models.CharField(max_length=50, default=None)
    symptoms = models.CharField(max_length=50,default=None,blank=True)



class Room(models.Model):
    def __str__(self):
        return str(self.number)
    number = models.IntegerField(default=0)
    patient = models.OneToOneField(
        Patient, on_delete=models.SET_NULL, null=True, blank=True)


class Admit(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.SET_NULL, null=True)
    room = models.ForeignKey(
        Room, on_delete=models.SET_NULL, null=True, blank=True)
    entry_time = models.DateTimeField(auto_now_add=True)
    exit_time = models.DateTimeField(blank=True, null=True)

    def __str__(self) -> str:
        return f"{str(self.patient)}-{str(self.room)}-{str(self.entry_time)}"


class Transaction(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.SET_NULL, null=True)
    doctor = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    prescription = models.CharField(max_length=50, default=None)
    created_time = models.DateTimeField(auto_now_add=True)

    def __str__(self) -> str:
        return f"{str(self.patient)}-{str(self.created_time)}"


class Doctor_Appointment(models.Model):
    doctor = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    patient = models.ForeignKey(Patient, on_delete=models.SET_NULL, null=True)
    slot_time = models.DateTimeField()

    def __str__(self) -> str:
        return f"{str(self.doctor)}-{str(self.patient)}-{str(self.slot_time)}"


class Test(models.Model):
    transaction = models.ForeignKey(
        Transaction, on_delete=models.SET_NULL, null=True)
    report_text = models.CharField(max_length=50, default=None)
    report_image = models.ImageField(upload_to='images/')

    def __str__(self) -> str:
        return f"{str(self.transaction)}-{str(self.report_text)[:5]}"


class Test_Appointment(models.Model):
    patient = models.ForeignKey(Patient, on_delete=models.SET_NULL, null=True)
    doctor = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    test_type = models.CharField(max_length=50, default=None)
    slot_time = models.DateTimeField()

    def __str__(self) -> str:
        return f"{str(self.patient)}-{str(self.doctor)}-{str(self.slot_time)}"
