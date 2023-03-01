from rest_framework.views import APIView
from rest_framework import permissions
from rest_framework.response import Response
from django.views.decorators.csrf import ensure_csrf_cookie
from database_admin.serializers import PatientSerializer
from django.utils.decorators import method_decorator
from database_admin.models import Patient

@method_decorator(ensure_csrf_cookie, name='dispatch')
class getAllPatient(APIView):
    permission_classes = (permissions.AllowAny, )

    def get(self, request, format=None):
        patient = Patient.objects.all()
        serializer = PatientSerializer(patient,many=True)
        return Response(serializer.data)