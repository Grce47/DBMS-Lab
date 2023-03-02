from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.contrib.auth.models import User
from job.models import UserProfile
from .models import Patient, Room
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
    #TODO Authentication
    # if(request.user.is_authenticated): 
    patientList = Patient.objects.all() 
    serializer = PatientSerializer(patientList, many=True)
    resonse = {}
    resonse['data'] = serializer.data
    rooms = Room.objects.all()
    for room in rooms:
        if room.patient == None:
            continue
        resonse[room.patient.id] = room.number
    return Response(resonse)
    
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
            phone = phone,
            prescription = 'None'
        )
        patient.save() 
        return Response({
            'Success': 'Data entered'
        })
    else:
        return Response({
            'Error': 'Send POST request'
        })
    
@api_view(['POST'])
def delete_patient(request): 
    #TODO Add security
    if(request.method == 'POST'):
        patient_id = request.data.get('id', None)
        if(patient_id == None):
            return Response({
                'Error': 'Id not given'
            })
        patient = Patient.objects.filter(id = patient_id)
        patient.delete()
        return Response({
            'Success': 'Deleted'
        })
    else: 
        return Response({
            'Error': 'Send POST Request'
        })
    

@api_view(['POST'])
def add_prescription(request):
    # TODO Add authentication 
    if(request.method == 'POST'):
        prescription = request.data.get('prescription', None)
        patient_id = request.data.get('patient_id', None)
        if(prescription == None): 
            return Response({
                'Error': 'prescription not sent'
            })
        if(patient_id == None): 
            return Response({
                'Error': 'patient_id not sent'
            })  
        patient = Patient.objects.get(id = patient_id) 
        patient.prescription = prescription
        patient.save()
        return Response({
            'Success': 'Prescription updated'
        })
    else: 
        return Response({
            'Error': 'Send POST Request'
        })
        

@api_view(['POST'])
def admit_patient(request): 
    #TODO add authentication
    patient_id = request.data.get('id', None)
    if(patient_id == None): 
        return Response({
            'Error': 'patient_id not sent'
        })
    available_room = Room.object.filter(patient=None).first() 
    if available_room is None: 
        return Response({
            'Error': 'Room not available'
        })
    room_number = available_room.number
    return Response({
        'Success': 'Admitted',
        'Room': f'{room_number}'
    })