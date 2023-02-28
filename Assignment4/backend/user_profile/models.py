from django.db import models
from django.contrib.auth.models import User


class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    designation = models.CharField(
        choices=(("1", "doctor"), ("2", "data_entry_operator"),
                 ("3", "front_desk_operator"), ("4", "database_admin")),
        default="1", max_length=20
    )

    def __str__(self) -> str:
        return str(self.user) + "-" + self.designation
