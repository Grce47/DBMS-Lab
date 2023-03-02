from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.contrib.auth.models import User
from job.models import UserProfile
from .models import Patient, Room, Transaction
from .serializers import PatientSerializer


@api_view(['GET',])
def getinfo(request):
    response = {
        'user': '-1',
        'job': '-1'
    }
    if (request.user.is_authenticated):
        response['user'] = request.user.username
        user = User.objects.filter(username=response['user']).first()
        response['job'] = UserProfile.objects.filter(
            user=user).first().designation
    else:
        response['error'] = 'Not Logged In'

    return Response(response)


@api_view(['POST'])
def add_user(request):
    if (request.user.is_authenticated):
        # check designation -> da
        # username , email, pass, job
        username = None
        email = None
        password = None
        designation = None
        user = User(username=username, email=email, password=password)
        user.save()
        job = UserProfile(user=user, designation=designation)
        job.save()


@api_view(['GET'])
def list_patients(request):
    # TODO Authentication
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
    if (request.method == 'POST'):
        name = request.data.get('name', None)
        age = request.data.get('age', None)
        address = request.data.get('address', None)
        phone = request.data.get('phone', None)
        symptoms = request.data.get('symptoms', None)
        if (name is None or age is None or address is None or phone is None or symptoms is None):
            return Response({"Error": "Form Error"})
        patient = Patient(
            name=name,
            age=age,
            address=address,
            phone=phone,
            symptoms=symptoms,
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
    # TODO Add security
    if (request.method == 'POST'):
        patient_id = request.data.get('id', None)
        if (patient_id == None):
            return Response({
                'Error': 'Id not given'
            })
        patient = Patient.objects.filter(id=patient_id)
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
    response = {}
    if (not request.user.is_authenticated):
        response['Error'] = 'Not Authenticated'
    else:
        user = User.objects.filter(username=request.user.username).first()
        job = UserProfile.objects.filter(user=user).first()
        print(user)
        print(job.designation)
        patient_id = request.data.get('patient_id', None)
        if (patient_id is None):
            response['Error'] = 'Patient Id not Found'
        else:
            patient = Patient.objects.filter(id=patient_id).first()
            if (job.designation != "doctor"):
                response['Error'] = 'Not Doctor'
            else:
                prescription = request.data.get('prescription', None)
                if (prescription is None):
                    response['Error'] = 'Prescription not found'
                else:
                    transaction = Transaction(
                        patient=patient, doctor=user, prescription=prescription)
                    transaction.save()
                    response['Success'] = 'Prescriptions Added'
    return Response(response)


@api_view(['POST'])
def admit_patient(request):
    # TODO add authentication
    # TODO add many checks
    patient_id = request.data.get('id', None)
    patient = Patient.objects.filter(id=patient_id)
    if (patient_id == None):
        return Response({
            'Error': 'patient_id not sent'
        })
    available_room = Room.objects.filter(patient=None).first()
    if available_room is None:
        return Response({
            'Error': 'Room not available'
        })
    room_number = available_room.number
    available_room.patient = patient.first()
    available_room.save()
    return Response({
        'Success': 'Admitted',
        'Room': f'{room_number}'
    })
