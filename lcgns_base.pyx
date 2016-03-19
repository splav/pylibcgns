# Read and write CGNSBase_t Nodes

#int cg_nbases(int fn, int *nbases);
@checked
def nbases(int fn):
    cdef int nbases
    return cg_nbases(fn, &nbases), nbases

#int cg_base_read(int file_number, int B, char *basename,
    #int *cell_dim, int *phys_dim);
@checked
def base_read(int fn, int B):
    cdef char bname[MAXNAMELENGTH]
    cdef int cell_dim
    cdef int phys_dim
    return cg_base_read(fn, B, bname, &cell_dim, &phys_dim), bname, cell_dim, phys_dim

#int cg_base_id(int fn, int B, double *base_id);
@checked
def base_id(int fn, int B):
    cdef double base_id
    return cg_base_id(fn, B, &base_id), base_id

#int cg_base_write(int file_number, const char * basename,
    #int cell_dim, int phys_dim, int *B);
@checked
def base_write(int file_number, basename, int cell_dim, int phys_dim):
    cdef int B
    return cg_base_write(file_number, basename, cell_dim, phys_dim, &B), B

#int cg_cell_dim(int fn, int B, int *cell_dim);
@checked
def cell_dim(int fn, int B):
    cdef int cell_dim
    return cg_cell_dim(fn, B, &cell_dim), cell_dim
