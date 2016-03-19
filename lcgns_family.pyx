# Read and write Family_t Nodes

#int cg_nfamilies(int file_number, int B, int *nfamilies);
@checked
def nfamilies(int fn, int B):
    cdef int nfamilies
    return cg_nfamilies(fn, B, &nfamilies), nfamilies

#int cg_family_read(int file_number, int B, int F,
    #char *family_name, int *nboco, int *ngeos);
@checked
def family_read(int fn, int B, int F):
    cdef char fname[MAXNAMELENGTH]
    cdef int nboco
    cdef int ngeos
    return cg_family_read(fn, B, F, fname, &nboco, &ngeos), fname, nboco, ngeos

#int cg_family_write(int file_number, int B,
    #const char * family_name, int *F);
@checked
def family_write(int fn, int B, family_name):
    cdef int F
    return cg_family_write(fn, B, family_name, &F), F

#int cg_nfamily_names(int file_number, int B, int F, int *nnames);
@checked
def nfamily_names(int fn, int B, int F):
    cdef int nnames
    return cg_nfamily_names(fn, B, F, &nnames), nnames

#int cg_family_name_read(int file_number, int B, int F,
    #int N, char *name, char *family);
@checked
def family_name_read(int fn, int B, int F, int N):
    cdef char name[MAXNAMELENGTH]
    cdef char family[MAXNAMELENGTH]

    return cg_family_name_read(fn, B, F, N, name, family), name, family

#int cg_family_name_write(int file_number, int B, int F,
    #const char *name, const char *family);
@checked
def family_name_write(int fn, int B, int F, name, family):
    return cg_family_name_write(fn, B, F, name, family)


# Read and write FamilyName_t Nodes

#int cg_famname_read(char *family_name);
@checked
def famname_read():
    cdef char family_name[MAXNAMELENGTH]
    return cg_famname_read(family_name), family_name

#int cg_famname_write(const char * family_name);
@checked
def famname_write(family_name):
    return cg_famname_write(family_name)

#int cg_nmultifam(int *nfams);
@checked
def nmultifam():
    cdef int nfams
    return cg_nmultifam(&nfams), nfams

#int cg_multifam_read(int N, char *name, char *family);
@checked
def multifam_read(int N):
    cdef char name[MAXNAMELENGTH]
    cdef char family[MAXNAMELENGTH]
    return cg_multifam_read(N, name, family), name, family

#int cg_multifam_write(const char *name, const char *family);
@checked
def multifam_write(const char *name, const char *family):
    return cg_multifam_write(name, family)

## Read and write FamilyBC_t Nodes

#int cg_fambc_read(int file_number, int B, int F, int BC,
    #char *fambc_name, BCType_t *bocotype);
@checked
def fambc_read(int fn, int B, int F, int BC):
    cdef char fambc_name[MAXNAMELENGTH]
    cdef BCType bocotype
    return cg_fambc_read(fn, B, F, BC, fambc_name, &bocotype), fambc_name, bocotype

#int cg_fambc_write(int file_number, int B, int F,
    #const char * fambc_name, BCType_t bocotype, int *BC);
@checked
def fambc_write(int fn, int B, int F, fambc_name, BCType bocotype):
    cdef int BC
    return cg_fambc_write(fn, B, F, fambc_name, bocotype, &BC), BC
