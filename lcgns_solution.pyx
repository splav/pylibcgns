# Read and write FlowSolution_t Nodes

#int cg_nsols(int fn, int B, int Z, int *nsols);
@checked
def nsols(int fn, int B, int Z):
    cdef int nsols
    return cg_nsols(fn, B, Z, &nsols), nsols

#int cg_sol_info(int fn, int B, int Z, int S, char *solname,
    #GridLocation_t *location);
@checked
def sol_info(int fn, int B, int Z, int S):
    cdef char solname[MAXNAMELENGTH]
    cdef GridLocation location
    return cg_sol_info(fn, B, Z, S, solname, &location), solname, location

#int cg_sol_id(int fn, int B, int Z,int S, double *sol_id);
@checked
def sol_id(int fn, int B, int Z,int S):
    cdef double sol_id
    return cg_sol_id(fn, B, Z, S, &sol_id), sol_id

#int cg_sol_write(int fn, int B, int Z, const char * solname,
    #GridLocation_t location, int *S);
@checked
def sol_write(int fn, int B, int Z, solname, GridLocation location):
    cdef int S
    return cg_sol_write(fn, B, Z, solname, location, &S), S

#int cg_sol_size(int fn, int B, int Z, int S,
    #int *data_dim, cgsize_t *dim_vals);
@checked
def sol_size(int fn, int B, int Z, int S):
    cdef int data_dim
    dim_vals = np.zeros((MAXDIMENSIONS,), dtype=np.int32, order='F')
    dim_valsptr = <cgsize_t *>np.PyArray_DATA(dim_vals)

    return  cg_sol_size(fn, B, Z, S, &data_dim, dim_valsptr), data_dim, dim_vals[0:data_dim]

#int cg_sol_ptset_info(int fn, int B, int Z, int S,
    #PointSetType_t *ptset_type, cgsize_t *npnts);
@checked
def sol_ptset_info(int fn, int B, int Z, int S):
    cdef cgsize_t npnts
    cdef PointSetType ptset_type
    return cg_sol_ptset_info(fn, B, Z, S, &ptset_type, &npnts), ptset_type, npnts

#int cg_sol_ptset_read(int fn, int B, int Z, int S, cgsize_t *pnts);
@checked
def sol_ptset_read(int fn, int B, int Z, int S):
    ptset_type, npnts = sol_ptset_info(fn, B, Z, S)
    pnts = np.zeros((npnts,), dtype=np.int32)
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)

    return cg_sol_ptset_read(fn, B, Z, S, pnts_ptr), pnts

#int cg_sol_ptset_write(int fn, int B, int Z, const char *solname,
    #GridLocation_t location,
    #PointSetType_t ptset_type, cgsize_t npnts,
    #const cgsize_t *pnts, int *S);
@checked
def sol_ptset_write(int fn, int B, int Z, solname, GridLocation location,
                    PointSetType ptset_type, cgsize_t npnts, np.ndarray pnts):
    cdef int S
    cdef cgsize_t * pntsptr
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)

    return cg_sol_ptset_write(fn, B, Z, solname, location, ptset_type, npnts, pnts_ptr, &S), S


# Read and write solution DataArray_t Nodes

#int cg_nfields(int fn, int B, int Z, int S, int *nfields);
@checked
def nfields(int fn, int B, int Z, int S):
    cdef int nfields
    return cg_nfields(fn, B, Z, S, &nfields), nfields

#int cg_field_info(int fn,int B,int Z,int S, int F,
    #DataType_t *type, char *fieldname);
@checked
def field_info(int fn, int B, int Z, int S, int F):
    cdef DataType type
    cdef char fieldname[MAXNAMELENGTH]
    return cg_field_info(fn, B, Z, S, F, &type, fieldname), type, fieldname

#int cg_field_read(int fn, int B, int Z, int S, const char *fieldname,
    #DataType_t type, const cgsize_t *rmin,
        #const cgsize_t *rmax, void *field_ptr);
@checked
def field_read(int fn, int B, int Z, int S, fieldname, DataType dtype,
               rmin, rmax):
    nrmin = np.asarray(rmin, dtype=np.int32, order='C')
    nrmax = np.asarray(rmax, dtype=np.int32, order='C')
    rminptr = <cgsize_t *>np.PyArray_DATA(nrmin)
    rmaxptr = <cgsize_t *>np.PyArray_DATA(nrmax)

    shape = tuple( int(e - s + 1) for s, e in zip(rmin,rmax))
    if shape[2] == 1:
        *shape, _ = shape
    cdtype = asnumpydtype(dtype)
    field = np.zeros(shape, dtype=cdtype, order='F')
    field_ptr = <void *>np.PyArray_DATA(field)

    return cg_field_read(fn, B, Z, S, fieldname, dtype, rminptr, rmaxptr, field_ptr), field

#int cg_field_id(int fn, int B, int Z,int S, int F, double *field_id);
@checked
def field_id(int fn, int B, int Z,int S, int F):
    cdef double field_id
    return cg_field_id(fn, B, Z, S, F, &field_id), field_id

#int cg_field_write(int fn,int B,int Z,int S,
    #DataType_t type, const char * fieldname,
    #const void * field_ptr, int *F);
@checked
def field_write(int fn, int B, int Z, int S, DataType type, const char *fieldname,
                np.ndarray field):
    cdef int F
    field_ptr = <void *>np.PyArray_DATA(field)
    return cg_field_write(fn, B, Z, S, type, fieldname, field_ptr, &F), F

#int cg_field_partial_write(int fn, int B, int Z, int S,
    #DataType_t type, const char * fieldname,
    #const cgsize_t *rmin, const cgsize_t *rmax,
        #const void * field_ptr, int *F);
@checked
def field_partial_write(int fn, int B, int Z, int S, DataType type, const char *fieldname,
    rmin, rmax, np.ndarray field):
    cdef int F
    nrmin = np.asarray(rmin, dtype=np.int32, order='C')
    nrmax = np.asarray(rmax, dtype=np.int32, order='C')
    rminptr = <cgsize_t *>np.PyArray_DATA(nrmin)
    rmaxptr = <cgsize_t *>np.PyArray_DATA(nrmax)
    field_ptr = <void *>np.PyArray_DATA(field)

    return cg_field_partial_write(fn, B, Z, S, type, fieldname, rminptr, rmaxptr, field_ptr, &F), F


# Read and write ConvergenceHistory_t Nodes

#int cg_convergence_read(int *iterations, char **NormDefinitions);
@checked
def convergence_read():
    cdef int iterations = 0
    cdef char *NormDefinitions_p
    err = cg_convergence_read(&iterations, &NormDefinitions_p)
    if not err:
        NormDefinitions = str(NormDefinitions_p)
        cg_free(NormDefinitions_p)
    else:
        NormDefinitions = ''
    return err, iterations, NormDefinitions

#int cg_convergence_write(int iterations, const char * NormDefinitions);
@checked
def convergence_write(int iterations, const char * NormDefinitions):
    return cg_convergence_write(iterations, NormDefinitions)
