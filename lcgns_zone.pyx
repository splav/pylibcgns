# Read and write Zone_t Nodes

#int cg_nzones(int fn, int B, int *nzones);
@checked
def nzones(int fn, int B):
    cdef int nzones
    return cg_nzones(fn, B, &nzones), nzones

#int cg_zone_read(int fn, int B, int Z, char *zonename, cgsize_t *size);
@checked
def zone_read(int fn, int B, int Z):
    cdef char zname[MAXNAMELENGTH]
    cdef cgsize_t *zsize
    cdef np.ndarray[dtype=np.int32_t, ndim=2] azsize

    cdef int dim
    e = cg_index_dim(fn, B, Z, &dim)
    if e:
        return e

    azsize = np.zeros((3,dim), dtype=np.int32, order='C')
    zsize = <cgsize_t *>azsize.data
    return cg_zone_read(fn, B, Z, zname, zsize), zname, azsize

#int cg_zone_type(int file_number, int B, int Z,
    #ZoneType_t *type);
@checked
def zone_type(int fn, int B, int Z):
    cdef ZoneType type
    return cg_zone_type(fn, B, Z, &type), type

#int cg_zone_id(int fn, int B, int Z, double *zone_id);
@checked
def zone_id(int fn, int B, int Z):
    cdef double zone_id
    return cg_zone_id(fn, B, Z, &zone_id), zone_id

#int cg_zone_write(int fn, int B, const char * zonename,
    #const cgsize_t * size, ZoneType_t type, int *Z);
@checked
def zone_write(int fn, int B, zonename, size, ZoneTypetype):
    cdef int Z
    cdef np.ndarray[dtype=np.int32_t, ndim=1] zsize
    cdef cgsize_t *ptrzs
    zsize = np.require(size.flatten(), dtype=np.int32)
    ptrzs = <cgsize_t *>zsize.data

    return cg_zone_write(fn, B, zonename, ptrzs, type, &Z), Z

#int cg_index_dim(int fn, int B, int Z, int *index_dim);
@checked
def index_dim(int fn, int B, int Z):
    cdef int index_dim
    return cg_index_dim(fn, B, Z, &index_dim), index_dim
