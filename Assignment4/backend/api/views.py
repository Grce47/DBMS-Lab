from rest_framework.response import Response
from rest_framework.decorators import api_view


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