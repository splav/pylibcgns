# Read and write SimulationType_t Node

#int cg_simulation_type_read(int file_number, int B,
    #SimulationType_t *type);
@checked
def simulation_type_read(int fn, int B):
    cdef SimulationType type
    return cg_simulation_type_read(fn, B, &type), type
#int cg_simulation_type_write(int file_number, int B,
    #SimulationType_t type);
@checked
def simulation_type_write(int fn, int B, SimulationType type):
    return cg_simulation_type_write(fn, B, type)

# Read and write BaseIterativeData_t Node

#int cg_biter_read(int file_number, int B, char *bitername, int *nsteps);
@checked
def biter_read(int fn, int B):
    cdef char bitername[MAXNAMELENGTH]
    cdef int nsteps
    return cg_biter_read(fn, B, bitername, &nsteps), bitername, nsteps

#int cg_biter_write(int file_number, int B, const char * bitername, int nsteps);
@checked
def biter_write(int fn, int B, const char * bitername, int nsteps):
    return cg_biter_write(fn, B, bitername, nsteps)

# Read and write ZoneIterativeData_t Node

#int cg_ziter_read(int file_number, int B, int Z, char *zitername);
@checked
def ziter_read(int fn, int B, int Z):
    cdef char zitername[MAXNAMELENGTH]
    return cg_ziter_read(fn, B, Z, zitername), zitername

#int cg_ziter_write(int file_number, int B, int Z, const char * zitername);
@checked
def ziter_write(int fn, int B, int Z, const char * zitername):
    return cg_ziter_write(fn, B, Z, zitername)

# Read and write Gravity_t Nodes

#int cg_gravity_read(int file_number, int B, float *gravity_vector);
@checked
def gravity_read(int fn, int B):
    _, _, pdim = base_read(fn, B)
    gravity_vector = np.zeros(pdim, dtype=np.float32, order='F')
    gravity_vector_ptr = <float *>np.PyArray_DATA(gravity_vector)
    return cg_gravity_read(fn, B, gravity_vector_ptr), gravity_vector

#int cg_gravity_write(int file_number, int B, float *const gravity_vector);
@checked
def gravity_write(int fn, int B, gravity_vector):
    ngravity_vector = np.asarray(gravity_vector, dtype=np.float32, order='F')
    gravity_vector_ptr = <float *>np.PyArray_DATA(ngravity_vector)
    return cg_gravity_write(fn, B, gravity_vector_ptr)

# Read and write Axisymmetry_t Nodes

#int cg_axisym_read(int file_number, int B, float *ref_point,
    #float *axis);
@checked
def axisym_read(int fn, int B):
    _, _, pdim = base_read(fn, B)
    ref_point = np.zeros(pdim, dtype=np.float32, order='F')
    ref_point_ptr = <float *>np.PyArray_DATA(ref_point)
    axis = np.zeros(pdim, dtype=np.float32, order='F')
    axis_ptr = <float *>np.PyArray_DATA(axis)
    return cg_axisym_read(fn, B, ref_point_ptr, axis_ptr), ref_point, axis

#int cg_axisym_write(int file_number, int B, float *const ref_point,
    #float *const axis);
@checked
def axisym_write(int fn, int B, ref_point, axis):
    nref_point = np.asarray(ref_point, dtype=np.float32, order='F')
    naxis = np.asarray(axis, dtype=np.float32, order='F')
    ref_point_ptr = <float *>np.PyArray_DATA(nref_point)
    axis_ptr = <float *>np.PyArray_DATA(naxis)
    return cg_axisym_write(fn, B, ref_point_ptr, axis_ptr)

# Read and write RotatingCoordinates_t Nodes

#int cg_rotating_read(float *rot_rate, float *rot_center);
@checked
def rotating_read():
    fn, B, _ = where()
    _, _, pdim = base_read(fn, B)
    rot_rate = np.zeros(pdim, dtype=np.float32, order='F')
    rot_rate_ptr = <float *>np.PyArray_DATA(rot_rate)
    rot_center = np.zeros(pdim, dtype=np.float32, order='F')
    rot_center_ptr = <float *>np.PyArray_DATA(rot_center)
    return cg_rotating_read(rot_rate_ptr, rot_center_ptr), rot_rate, rot_center

#int cg_rotating_write(float *const rot_rate, float *const rot_center);
@checked
def rotating_write(rot_rate, rot_center):
    nrot_rate = np.asarray(rot_rate, dtype=np.float32, order='F')
    nrot_center = np.asarray(rot_center, dtype=np.float32, order='F')
    rot_rate_ptr = <float *>np.PyArray_DATA(nrot_rate)
    rot_center_ptr = <float *>np.PyArray_DATA(nrot_center)
    return cg_rotating_write(rot_rate_ptr, rot_center_ptr)