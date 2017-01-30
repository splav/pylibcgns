# Read and write GridCoordinates_t Nodes

#int cg_ngrids(int file_number, int B, int Z, int *ngrids);
@checked
def ngrids(int fn, int B, int Z):
    cdef int ngrids
    return cg_ngrids(fn, B, Z, &ngrids), ngrids

#int cg_grid_read(int file_number, int B, int Z, int G, char *gridname);
@checked
def grid_read(int fn, int B, int Z, int G):
    cdef char gridname[MAXNAMELENGTH]
    return cg_grid_read(fn, B, Z, G, gridname), gridname

#int cg_grid_write(int file_number, int B, int Z,
    #const char * zcoorname, int *G);
@checked
def grid_write(int fn, int B, int Z, zcoorname):
    cdef int G
    return cg_grid_write(fn, B, Z, zcoorname, &G), G


# Read and write GridCoordinates_t/DataArray_t Nodes

#int cg_ncoords(int fn, int B, int Z, int *ncoords);
@checked
def ncoords(int fn, int B, int Z):
    cdef int ncoords
    return cg_ncoords(fn, B, Z, &ncoords), ncoords

#int cg_coord_info(int fn, int B, int Z, int C,
    #DataType_t *type, char *coordname);
@checked
def coord_info(int fn, int B, int Z, int C):
    cdef DataType type
    cdef char coordname[MAXNAMELENGTH]
    return cg_coord_info(fn, B, Z, C, &type, coordname), type, coordname

#int cg_coord_read(int fn, int B, int Z, const char * coordname,
    #DataType_t type, const cgsize_t * rmin,
    #const cgsize_t * rmax, void *coord);
@checked
def coord_read(int fn, int B, int Z, coordname,
                dtype, rmin, rmax):
    cdef nrmin = to_cgtype_array(rmin)
    cdef nrmax = to_cgtype_array(rmax)

    shape = tuple( int(e - s + 1) for s, e in zip(rmin,rmax))
    if shape[2] == 1:
        *shape, _ = shape
    ctype = fromnumpydtype(dtype)
    coord = fbuf(shape, dtype)

    return cg_coord_read(fn, B, Z, coordname, ctype, <cgsize_t *>ptr(nrmin), <cgsize_t *>ptr(nrmax), ptr(coord)), coord

#int cg_coord_id(int fn, int B, int Z, int C, double *coord_id);
@checked
def coord_id(int fn, int B, int Z, int C):
    cdef double coord_id
    return cg_coord_id(fn, B, Z, C, &coord_id), coord_id

#int cg_coord_write(int fn, int B, int Z,
    #DataType_t type, const char * coordname,
    #const void * coord_ptr, int *C);
@checked
def coord_write(int fn, int B, int Z,
                coordname, np.ndarray coord):
    cdef int C
    dtype = fromnumpydtype(coord.dtype)
    return cg_coord_write(fn, B, Z, dtype, coordname, ptr(coord), &C), C

#int cg_coord_partial_write(int fn, int B, int Z,
    #DataType_t type, const char * coordname,
    #const cgsize_t *rmin, const cgsize_t *rmax,
    #const void * coord_ptr, int *C);
@checked
def coord_partial_write(int fn, int B, int Z,
                        coordname, rmin, rmax, coord):
    cdef int C
    cdef nrmin = to_cgtype_array(rmin)
    cdef nrmax = to_cgtype_array(rmax)
    coord_ptr = <void *>np.PyArray_DATA(coord)
    dtype = fromnumpydtype(coord.dtype)

    return cg_coord_partial_write(fn, B, Z, dtype, coordname,  <cgsize_t *>ptr(nrmin), <cgsize_t *>ptr(nrmax), coord_ptr, &C), C
