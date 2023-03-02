# Generated by Django 4.1.7 on 2023-03-02 10:57

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_room_patient_prescription'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='room',
            name='available',
        ),
        migrations.AddField(
            model_name='room',
            name='patient',
            field=models.OneToOneField(default=None, on_delete=django.db.models.deletion.DO_NOTHING, to='api.patient'),
        ),
        migrations.AlterField(
            model_name='patient',
            name='address',
            field=models.CharField(default=None, max_length=50),
        ),
        migrations.AlterField(
            model_name='patient',
            name='age',
            field=models.CharField(default=None, max_length=50),
        ),
        migrations.AlterField(
            model_name='patient',
            name='name',
            field=models.CharField(default=None, max_length=50),
        ),
        migrations.AlterField(
            model_name='patient',
            name='phone',
            field=models.CharField(default=None, max_length=50),
        ),
        migrations.AlterField(
            model_name='patient',
            name='prescription',
            field=models.CharField(default=None, max_length=50),
        ),
        migrations.AlterField(
            model_name='patient',
            name='symptoms',
            field=models.CharField(default=None, max_length=50),
        ),
    ]
