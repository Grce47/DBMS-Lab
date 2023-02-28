from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('doctors/', include('doctors.urls')),
    path('fdo/', include('front_desk_operator.urls')),
    path('deo/', include('data_entry_operator.urls')),
    path('da/', include('data_entry_operator.urls')),
]
