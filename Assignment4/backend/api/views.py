from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.contrib.auth.models import User
from job.models import UserProfile
from .models import Patient
from .serializers import PatientSerializer

@api_view(['GET',])
def getinfo(request):
    response = {
        'user' : '-1',
        'job' : '-1'
    }
    if(request.user.is_authenticated):
        response['user'] = request.user.username
        response['job'] = 'can find'
    else:
        response['error'] = 'Not Logged In'

    return Response(response)

@api_view(['POST'])
def add_user(request):
    if(request.user.is_authenticated):
        # check designation -> da
        # username , email, pass, job
        username=None
        email=None
        password=None
        designation=None
        user = User(username=username,email=email,password=password)
        user.save()
        job = UserProfile(user=user,designation=designation)
        job.save()

@api_view(['GET'])
def list_patients(request): 
    if(request.user.is_authenticated): 
        patientList = Patient.objects.all() 
        serializer = PatientSerializer(patientList, many=True)
        return Response(serializer.data)
    
@api_view(['POST'])
def add_patient(request): 
    #TODO Add security check for login
    if(request.method == 'POST'):
        name = request.data.get('name', None)
        age = request.data.get('age', None)
        address = request.data.get('address', None)
        phone = request.data.get('phone', None)
        patient = Patient(
            name = name, 
            age = age,
            address = address, 
            phone = phone
        )
        patient.save() 
        return Response({
            'Success': 'Data entered'
        })
    else:
        return Response({
            'Error': 'Send POST request'
        })
    
