from django.contrib.auth.models import User
from rest_framework.views import APIView
from rest_framework import permissions
from django.contrib import auth
from rest_framework.response import Response
from .models import UserProfile
from django.views.decorators.csrf import ensure_csrf_cookie, csrf_protect
from django.utils.decorators import method_decorator


# @method_decorator(csrf_protect, name='dispatch')
class CheckAuthenticatedView(APIView):
    # permission_classes = (permissions.AllowAny, )

    def get(self, request, format=None):
        user = self.request.user
        
        resp = Response({"ok":"ok"})
        resp.set_cookie('token','umang',samesite='Strict')
        return resp
        try:
            isAuthenticated = user.is_authenticated

            if isAuthenticated:
                return Response({'isAuthenticated': 'success', 'user': UserProfile.objects.filter(user=user).first().designation})
            else:
                return Response({'isAuthenticated': 'error'})
        except:
            return Response({'error': 'Something went wrong when checking authentication status'})


@method_decorator(csrf_protect, name='dispatch')
class SignupView(APIView):
    permission_classes = (permissions.AllowAny, )

    def post(self, request, format=None):
        data = self.request.data

        username = data['username']
        password = data['password']
        designation = data['designation']
        list_of_designations = ['doctor', 'database_admin',
                                'data_entry_operator', 'front_desk_operator']

        try:

            if User.objects.filter(username=username).exists():
                return Response({'error': 'Username already exists'})
            else:
                if len(password) < 6:
                    return Response({'error': 'Password must be at least 6 characters'})
                else:
                    if designation not in list_of_designations:
                        return Response({'error': 'Wrong designation'})

                    user = User.objects.create_user(
                        username=username, password=password)

                    user = User.objects.get(id=user.id)

                    user_profile = UserProfile(
                        user=user, designation=designation)
                    user_profile.save()

                    return Response({'success': 'User created successfully'})
        except:
            return Response({'error': 'Something went wrong when registering account'})


@method_decorator(csrf_protect, name='dispatch')
class LoginView(APIView):
    permission_classes = (permissions.AllowAny, )

    def post(self, request, format=None):
        data = self.request.data

        if (self.request.user.is_authenticated):
            return Response({'error': 'already logged in'})

        username = data['username']
        password = data['password']

        try:
            user = auth.authenticate(username=username, password=password)

            if user is not None:
                auth.login(request, user)
                return Response({'success': 'User authenticated', 'username': username})
            else:
                return Response({'error': 'Error Authenticating'})
        except:
            return Response({'error': 'Something went wrong when logging in'})


@method_decorator(csrf_protect, name='dispatch')
class LogoutView(APIView):
    permission_classes = (permissions.AllowAny, )
    def post(self, request, format=None):
        try:
            auth.logout(request)
            return Response({'success': 'Loggout Out'})
        except:
            return Response({'error': 'Something went wrong when logging out'})


@method_decorator(ensure_csrf_cookie, name='dispatch')
class GetCSRFToken(APIView):
    permission_classes = (permissions.AllowAny, )

    def get(self, request, format=None):
        return Response({'success': 'CSRF cookie set'})
