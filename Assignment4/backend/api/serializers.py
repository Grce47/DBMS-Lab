from rest_framework.serializers import ModelSerializer, SerializerMethodField
from .models import Patient, Transaction
from job.models import UserProfile
from django.contrib.auth.models import User


class UserSerializer(ModelSerializer):
    designation = SerializerMethodField('eval_job')

    def eval_job(self, foo):
        job = UserProfile.objects.filter(user=foo)
        if (len(job) == 0):
            return ""
        return job.first().designation

    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'designation')


class PatientSerializer(ModelSerializer):
    prescription = SerializerMethodField('eval_pres')

    def eval_pres(self, foo):
        transaction = Transaction.objects.filter(patient=foo)
        if len(transaction) == 0:
            return ""
        return transaction.last().prescription

    class Meta:
        model = Patient
        fields = ('id', 'name', 'address', 'phone',
                  'age', 'symptoms', 'prescription')
