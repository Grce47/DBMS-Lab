from rest_framework.serializers import ModelSerializer, SerializerMethodField
from .models import Patient, Transaction


class PatientSerializer(ModelSerializer):
    prescription = SerializerMethodField('eval_pres')

    def eval_pres(self, foo):
        transaction = Transaction.objects.filter(patient=foo)
        if len(transaction) == 0:
            return ""
        return transaction.last().prescription

    class Meta:
        model = Patient
        fields = ('id', 'name', 'address', 'phone', 'age', 'symptoms','prescription')
