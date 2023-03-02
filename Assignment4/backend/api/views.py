from rest_framework.response import Response
from rest_framework.decorators import api_view
from django.contrib.auth.models import User
from job.models import UserProfile
from .models import Patient, Room, Transaction, Doctor_Appointment
from .serializers import PatientSerializer
from datetime import datetime, timedelta
from django.utils import timezone


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


@api_view(['POST'])
def get_slot(request):
    response = {}
    if (not request.user.is_authenticated):
        response['Error'] = "Not Logged In"
        return Response(response)

    pref_time_slot = request.data.get('date', None)

    if (pref_time_slot is None):
        response['Error'] = "Form Error"
        return Response(response)

    user = request.user
    job = UserProfile.objects.filter(user=user)
    if (len(job) == 0):
        response['Error'] = "Wrong User"
        return Response(response)
    if (job.first().designation != "front_desk_operator"):
        response['Error'] = "Not Front Desk Operator"
        return Response(response)

    my_date = datetime.strptime(pref_time_slot, "%a %b %d %Y").date()

    time_slots = []
    current_time = datetime(year=my_date.year, month=my_date.month,
                            day=my_date.day, hour=14, minute=0, second=0)
    end_time = datetime(year=my_date.year, month=my_date.month,
                        day=my_date.day, hour=17, minute=0, second=0)

    while current_time < end_time:
        time_slots.append(current_time.time())
        current_time += timedelta(hours=1)

    doctor_apps = Doctor_Appointment.objects.all()

    free_time_slots = []
    for time_slot in time_slots:
        flag = 0
        for doctor_app in doctor_apps:
            if doctor_app.slot_time.time() == time_slot and doctor_app.slot_time.date() == my_date:
                flag += 1
        if flag != len(UserProfile.objects.filter(designation="doctor")):
            free_time_slots.append(time_slot)

    response['Success'] = free_time_slots
    return Response(response)


@api_view(['POST'])
def book_slot(request):
    response = {}
    if (not request.user.is_authenticated):
        response['Error'] = "Not Logged In"
        return Response(response)

    pref_date = request.data.get('date', None)
    if (pref_date is None):
        response['Error'] = "Form Error"
        return Response(response)

    pref_time = request.data.get('time', None)
    if pref_time is None:
        response['Error'] = "Form Error"
        return Response(response)

    patient_id = request.data.get('patient', None)
    if patient_id is None:
        response['Error'] = "Form Error"
        return Response(response)

    my_date = datetime.strptime(
        pref_date + " " + pref_time, "%a %b %d %Y %H:%M:%S")

    timezone.activate(timezone.get_current_timezone())

    my_date = timezone.make_aware(my_date)

    doctor_apps = Doctor_Appointment.objects.all()

    doctor_id = []

    booked = False

    for doctor_app in doctor_apps:
        if doctor_app.slot_time == my_date:
            doctor_id.append(doctor_app.doctor.id)

    all_doctors = UserProfile.objects.filter(designation="doctor")
    for doctor in all_doctors:
        if doctor.user.id not in doctor_id:
            booked = True
            Doctor_Appointment(doctor=doctor.user, patient=Patient.objects.filter(
                id=patient_id).first(), slot_time=my_date).save()
            break

    if booked:
        response['Success'] = 'Booking Done'
    else:
        response['Error'] = 'Booking Error'

    return Response(response)
