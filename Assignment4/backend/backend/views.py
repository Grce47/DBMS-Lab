from rest_framework.response import Response
from rest_framework.decorators import api_view
from backend.utils import getPatient

@api_view(['GET'])
def getRoutes(request):
    return Response(getPatient())