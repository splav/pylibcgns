# Read and write ZoneSubRegion_t Nodes

#int cg_nsubregs(int fn, int B, int Z, int *nsubreg);
@checked
def nsubregs(int fn, int B, int Z):
    cdef int nsubreg
    return cg_nsubregs(fn, B, Z, &nsubreg), nsubreg

#int cg_subreg_info(int fn, int B, int Z, int S, char *regname,
    #int *dimension, GridLocation_t *location,
    #PointSetType_t *ptset_type, cgsize_t *npnts,
    #int *bcname_len, int *gcname_len);
@checked
def subreg_info(int fn, int B, int Z, int S):
    cdef char regname[MAXNAMELENGTH]
    cdef int dimension
    cdef GridLocation location
    cdef PointSetType ptset_type
    cdef cgsize_t npnts
    cdef int bcname_len
    cdef int gcname_len
    return (cg_subreg_info(fn, B, Z, S, regname, &dimension, &location, &ptset_type, &npnts, &bcname_len, &gcname_len),
            regname, dimension, location, ptset_type, npnts, bcname_len, gcname_len)


#int cg_subreg_ptset_read(int fn, int B, int Z, int S, cgsize_t *pnts);
@checked
def subreg_ptset_read(int fn, int B, int Z, int S):
    *_, npnts, _, _ = subreg_info(fn, B, Z, S)
    pnts = np.zeros((npnts,), dtype=np.int32, order='F')
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)

    return cg_subreg_ptset_read(fn, B, Z, S, pnts_ptr), pnts

#int cg_subreg_bcname_read(int fn, int B, int Z, int S, char *bcname);
@checked
def subreg_bcname_read(int fn, int B, int Z, int S):
    *_, bcname_len, _ = subreg_info(fn, B, Z, S)
    bcname = " " * (bcname_len+1)
    return cg_subreg_bcname_read(fn, B, Z, S, bcname), bcname


#int cg_subreg_gcname_read(int fn, int B, int Z, int S, char *gcname);
@checked
def subreg_gcname_read(int fn, int B, int Z, int S):
    *_, gcname_len = subreg_info(fn, B, Z, S)
    gcname = " " * (gcname_len+1)
    return cg_subreg_gcname_read(fn, B, Z, S, gcname), gcname

#int cg_subreg_ptset_write(int fn, int B, int Z, const char *regname,
    #int dimension, GridLocation_t location,
    #PointSetType_t ptset_type, cgsize_t npnts,
    #const cgsize_t *pnts, int *S);
@checked
def subreg_ptset_write(int fn, int B, int Z, const char *regname, int dimension, GridLocation location,
        PointSetType ptset_type, cgsize_t npnts, np.ndarray pnts):
    cdef int S
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)
    return cg_subreg_ptset_write(fn, B, Z, regname, dimension, location, ptset_type, npnts, pnts_ptr, &S), S

#int cg_subreg_bcname_write(int fn, int B, int Z, const char *regname,
    #int dimension, const char *bcname, int *S);
@checked
def subreg_bcname_write(int fn, int B, int Z, const char *regname, int dimension, const char *bcname):
    cdef int S
    return cg_subreg_bcname_write(fn, B, Z, regname, dimension, bcname, &S), S

#int cg_subreg_gcname_write(int fn, int B, int Z, const char *regname,
    #int dimension, const char *gcname, int *S);
@checked
def subreg_gcname_write(int fn, int B, int Z, const char *regname, int dimension, const char *gcname):
    cdef int S
    return cg_subreg_gcname_write(fn, B, Z, regname, dimension, gcname, &S), S
