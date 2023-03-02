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
    patient = models.OneToOneField(
        Patient, on_delete=models.SET_NULL, null=True, blank=True)


class Admit(models.Model):
    patient_id = models.IntegerField()
    room_number = models.IntegerField()
    entry_time = models.DateTimeField(auto_now_add=True)
    exit_time = models.DateTimeField()

    def __str__(self) -> str:
        return f"{str(self.patient_id)}-{str(self.room_number)}-{str(self.entry_time)}"


class Transaction(models.Model):
    patient_id = models.IntegerField()
    doctor_id = models.IntegerField()
    prescription = models.CharField(max_length=50, default=None)
    created_time = models.DateTimeField(auto_now_add=True)

    def __str__(self) -> str:
        return f"{str(self.patient_id)}-{str(self.created_time)}"


class Doctor_Appointment(models.Model):
    doctor_id = models.IntegerField()
    patient_id = models.IntegerField()
    slot_time = models.DateTimeField()

    def __str__(self) -> str:
        return f"{self.doctor_id}-{self.patient_id}-{str(self.slot_time)}"


class Test(models.Model):
    transanction_id = models.IntegerField()
    patient_id = models.IntegerField()
    doctor_id = models.IntegerField()
    report_text = models.CharField(max_length=50, default=None)
    report_image = models.ImageField(upload_to='images/')

    def __str__(self) -> str:
        return f"{self.transanction_id}-{self.patient_id}"


class Test_Appointment(models.Model):
    patient_id = models.IntegerField()
    doctor_id = models.IntegerField()
    test_type = models.CharField(max_length=50)
    slot_time = models.DateTimeField()

    def __str__(self) -> str:
        return f"{self.patient_id}-{self.doctor_id}-{str(self.slot_time)}"
