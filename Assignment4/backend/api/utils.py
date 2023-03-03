from job.models import UserProfile

DATABASE_ADMIN = 'database_admin'
DOCTOR = 'doctor'
DATA_ENTRY_OPERATOR = 'data_entry_operator'
FRONT_DESK_OPERATOR = 'front_desk_operator'

def check_designation(user, designation: str) -> bool:
    '''
        checks if user's designation mathces with query designation
    '''
    job = UserProfile.objects.filter(user=user)
    if (len(job) == 0):
        return False
    return job.first().designation == designation


def designation_in_list(designation: str) -> bool:
    '''
        given designation in [doctor,front_desk_operator...,]
    '''
    return designation == DATA_ENTRY_OPERATOR or designation == DATABASE_ADMIN or designation == DOCTOR or designation == FRONT_DESK_OPERATOR
