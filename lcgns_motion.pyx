# Read and write RigidGridMotion_t Nodes

#int cg_n_rigid_motions(int file_number, int B, int Z,
    #int *n_rigid_motions);
@checked
def n_rigid_motions(int fn, int B, int Z):
    cdef int n_rigid_motions
    return cg_n_rigid_motions(fn, B, Z, &n_rigid_motions), n_rigid_motions

#int cg_rigid_motion_read(int file_number, int B, int Z, int R,
    #char *name, RigidGridMotionType_t *type);
@checked
def rigid_motion_read(int fn, int B, int Z, int R):
    cdef char name[MAXNAMELENGTH]
    cdef RigidGridMotionType type
    return cg_rigid_motion_read(fn, B, Z, R, name, &type), name, type

#int cg_rigid_motion_write(int file_number, int B, int Z,
    #const char * name, RigidGridMotionType_t type, int *R);
@checked
def rigid_motion_write(int fn, int B, int Z, const char * name, RigidGridMotionType type):
    cdef int R
    return cg_rigid_motion_write(fn, B, Z, name, type, &R)

# Read and write ArbitraryGridMotion_t Nodes

#int cg_n_arbitrary_motions(int file_number, int B, int Z,
    #int *n_arbitrary_motions);
@checked
def n_arbitrary_motions(int fn, int B, int Z):
    cdef int n_arbitrary_motions
    return cg_n_arbitrary_motions(fn, B, Z, &n_arbitrary_motions), n_arbitrary_motions

#int cg_arbitrary_motion_read(int file_number, int B, int Z, int A,
    #char *name, ArbitraryGridMotionType_t *type);
@checked
def arbitrary_motion_read(int fn, int B, int Z, int R):
    cdef char name[MAXNAMELENGTH]
    cdef ArbitraryGridMotionType type
    return cg_arbitrary_motion_read(fn, B, Z, R, name, &type), name, type

#int cg_arbitrary_motion_write(int file_number, int B, int Z,
    #const char * amotionname, ArbitraryGridMotionType_t type,
    #int *A);
@checked
def arbitrary_motion_write(int fn, int B, int Z, const char * name, ArbitraryGridMotionType type):
    cdef int R
    return cg_arbitrary_motion_write(fn, B, Z, name, type, &R)
