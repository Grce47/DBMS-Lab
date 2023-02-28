from django.contrib import admin
from django.urls import path, include
from user_profile.views import CheckAuthenticatedView, SignupView, LoginView, LogoutView, GetCSRFToken

urlpatterns = [
    path('admin/', admin.site.urls),
    path('doctors/', include('doctors.urls')),
    path('fdo/', include('front_desk_operator.urls')),
    path('deo/', include('data_entry_operator.urls')),
    path('da/', include('data_entry_operator.urls')),
    path('authenticated/', CheckAuthenticatedView.as_view()),
    path('register/', SignupView.as_view()),
    path('login/', LoginView.as_view()),
    path('logout/', LogoutView.as_view()),
    path('csrf_cookie/', GetCSRFToken.as_view())
]
