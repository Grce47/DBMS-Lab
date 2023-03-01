from django.shortcuts import render,redirect
from django.contrib.auth.forms import UserCreationForm
from django.contrib import messages
from .models import UserProfile
from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required

def regster(request):
    if request.method == 'POST':
        form = UserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            username = form.cleaned_data.get('username')
            job = form.data.get('job')
            user = User.objects.filter(username=username).first()
            user_pro = UserProfile(user=user,designation=job)
            user_pro.save()
            messages.success(request,f'User Added for {username} with designation as {job}!')
            return redirect('')
    else:
        form = UserCreationForm()

    context = {
        'form' : form
    }
    return render(request,'job/register.html',context)
