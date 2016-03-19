# Read and write DiscreteData_t Nodes

#int cg_ndiscrete(int file_number, int B, int Z, int *ndiscrete);
@checked
def ndiscrete(int fn, int B, int Z):
    cdef int ndiscrete
    return cg_ndiscrete(fn, B, Z, &ndiscrete), ndiscrete

#int cg_discrete_read(int file_number, int B, int Z, int D,
    #char *discrete_name);
@checked
def discrete_read(int fn, int B, int Z, int D):
    cdef char discrete_name[MAXNAMELENGTH]
    return cg_discrete_read(fn, B, Z, D, discrete_name), discrete_name

#int cg_discrete_write(int file_number, int B, int Z,
    #const char * discrete_name, int *D);
@checked
def discrete_write(int fn, int B, int Z, const char * discrete_name):
    cdef int D
    return cg_discrete_write(fn, B, Z, discrete_name, &D), D

#int cg_discrete_size(int fn, int B, int Z, int D,
    #int *data_dim, cgsize_t *dim_vals);
@checked
def discrete_size(int fn, int B, int Z, int D):
    cdef int data_dim
    cdef cgsize_t* dim_vals_ptr
    _, cdim, _ = base_read(fn, B)
    dim_vals = np.ones((cdim,), dtype=np.int32, order='F')
    dim_vals_ptr = <cgsize_t *>np.PyArray_DATA(dim_vals)
    return cg_discrete_size(fn, B, Z, D, &data_dim, dim_vals_ptr), data_dim, dim_vals[0:data_dim]

#int cg_discrete_ptset_info(int fn, int B, int Z, int D,
    #PointSetType_t *ptset_type, cgsize_t *npnts);
@checked
def discrete_ptset_info(int fn, int B, int Z, int D):
    cdef PointSetType ptset_type
    cdef cgsize_t npnts
    return cg_discrete_ptset_info(fn, B, Z, D, &ptset_type, &npnts), ptset_type, npnts

#int cg_discrete_ptset_read(int fn, int B, int Z, int D,
    #cgsize_t *pnts);
@checked
def discrete_ptset_read(int fn, int B, int Z, int D):
    cdef cgsize_t* pnts_ptr
    npnts, _ = discrete_ptset_info(fn, B, Z, D)
    ztype = zone_type(fn, B, Z)
    _, cdim, pdim = base_read(fn, B)
    if ztype == Unstructured:
      dim = 1
    elif ztype == Structured:
      dim = cdim

    pnts = np.zeros((npnts,dim), dtype=np.int32)
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)
    return cg_discrete_ptset_read(fn, B, Z, D, pnts_ptr)

#int cg_discrete_ptset_write(int fn, int B, int Z,
    #const char *discrete_name, GridLocation_t location,
    #PointSetType_t ptset_type, cgsize_t npnts,
    #const cgsize_t *pnts, int *D);
@checked
def discrete_ptset_write(int fn, int B, int Z,
    const char *discrete_name, GridLocation location,
    PointSetType ptset_type, cgsize_t npnts,
    np.ndarray pnts):
    cdef int D
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)
    return cg_discrete_ptset_write(fn, B, Z, discrete_name, location, ptset_type, npnts, pnts_ptr, &D), D
