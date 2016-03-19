# Read and write ZoneGridConnectivity_t Nodes

#int cg_nzconns(int fn, int B, int Z, int *nzconns);
@checked
def nzconns(int fn, int B, int Z):
    cdef int nzconns
    return cg_nzconns(fn, B, Z, &nzconns), nzconns

#int cg_zconn_read(int fn, int B, int Z, int C, char *name);
@checked
def zconn_read(int fn, int B, int Z, int C):
    cdef char name[MAXNAMELENGTH]
    return cg_zconn_read(fn, B, Z, C, name), name

#int cg_zconn_write(int fn, int B, int Z, const char *name, int *C);
@checked
def zconn_write(int fn, int B, int Z, const char *name):
    cdef int C
    return cg_zconn_write(fn, B, Z, name, &C), C

#int cg_zconn_get(int fn, int B, int Z, int *C);
@checked
def zconn_get(int fn, int B, int Z):
    cdef int C
    return cg_zconn_get(fn, B, Z, &C), C

#int cg_zconn_set(int fn, int B, int Z, int C);
@checked
def zconn_set(int fn, int B, int Z, int C):
    return cg_zconn_set(fn, B, Z, C)


# Read and write OversetHoles_t Nodes

#int cg_nholes(int fn, int B, int Z, int *nholes);
@checked
def nholes(int fn, int B, int Z):
    cdef int nholes
    return cg_nholes(fn, B, Z, &nholes), nholes

#int cg_hole_info(int fn, int B, int Z, int I, char *holename,
    #GridLocation_t *location,  PointSetType_t *ptset_type,
    #int *nptsets, cgsize_t *npnts);
@checked
def hole_info(int fn, int B, int Z, int I):
    cdef char holename[MAXNAMELENGTH]
    cdef GridLocation location
    cdef PointSetType ptset_type
    cdef int nptsets
    cdef cgsize_t npnts

    return (cg_hole_info(fn, B, Z, I, holename, &location, &ptset_type, &nptsets, &npnts),
            holename, location, ptset_type, nptsets, npnts)

#int cg_hole_read(int fn, int B, int Z, int I, cgsize_t *pnts);
@checked
def hole_read(int fn, int B, int Z, int I):
    cdef int npnts
    *_, npnts = hole_info
    pnts = np.zeros((npnts,), dtype=np.int32, order='F')
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)
    return cg_hole_read(fn, B, Z, I, pnts_ptr), pnts

#int cg_hole_id(int fn, int B, int Z, int I, double *hole_id);
@checked
def hole_id(int fn, int B, int Z, int I):
    cdef double hole_id
    return cg_hole_id(fn, B, Z, I, &hole_id), hole_id

#int cg_hole_write(int fn, int B, int Z, const char * holename,
    #GridLocation_t location, PointSetType_t ptset_type,
    #int nptsets, cgsize_t npnts, const cgsize_t * pnts, int *I);
@checked
def hole_write(int fn, int B, int Z, const char * holename,
                GridLocation location, PointSetType ptset_type,
                int nptsets, cgsize_t npnts, np.ndarray pnts):
    cdef int I
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)

    return cg_hole_write(fn, B, Z, holename, location, ptset_type, nptsets, npnts, pnts_ptr, &I), I


# Read and write GridConnectivity_t Nodes

#int cg_nconns(int fn, int B, int Z, int *nconns);
@checked
def nconns(int fn, int B, int Z):
    cdef int nconns
    return cg_nconns(fn, B, Z, &nconns), nconns

#int cg_conn_info(int file_number, int B, int Z, int I,
    #char *connectname, GridLocation_t *location,
    #GridConnectivityType_t *type,
    #PointSetType_t *ptset_type,
    #cgsize_t *npnts, char *donorname,
    #ZoneType_t *donor_zonetype,
    #PointSetType_t *donor_ptset_type,
    #DataType_t *donor_datatype,
    #cgsize_t *ndata_donor);
@checked
def conn_info(int fn, int B, int Z, int I):
    cdef char connectname[MAXNAMELENGTH]
    cdef GridLocation location
    cdef GridConnectivityType type
    cdef PointSetType ptset_type
    cdef cgsize_t npnts
    cdef char donorname[MAXNAMELENGTH],
    cdef ZoneType donor_zonetype
    cdef PointSetType donor_ptset_type
    cdef DataType donor_datatype
    cdef cgsize_t ndata_donor
    return (cg_conn_info(fn, B, Z, I, connectname, &location, &type, &ptset_type, &npnts, donorname,
                            &donor_zonetype, &donor_ptset_type, &donor_datatype, &ndata_donor),
                            connectname, location, type, ptset_type, npnts, donorname,
                            donor_zonetype, donor_ptset_type, donor_datatype, ndata_donor)

#int cg_conn_read(int file_number, int B, int Z, int I, cgsize_t *pnts,
    #DataType_t donor_datatype,
    #cgsize_t *donor_data);
@checked
def conn_read(int fn, int B, int Z, int I, DataType donor_datatype):
    cdef int npnts
    cdef int ndata_donor
    _,_,_,_,npnts,*_,ndata_donor = conn_info(fn, B, Z, I)

    pnts = np.zeros((npnts,), dtype=np.int32, order='F')
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)
    donor_data = np.zeros((ndata_donor,), dtype=np.int32, order='F')
    donor_data_ptr = <cgsize_t *>np.PyArray_DATA(donor_data)
    return cg_conn_read(fn, B, Z, I, pnts_ptr, donor_datatype, donor_data_ptr), pnts, donor_data

#int cg_conn_id(int fn, int B, int Z, int I, double *conn_id);
@checked
def conn_id(int fn, int B, int Z, int I):
    cdef double conn_id
    return cg_conn_id(fn, B, Z, I, &conn_id), conn_id

#int cg_conn_write(int file_number, int B, int Z,
    #const char * connectname, GridLocation_t location,
    #GridConnectivityType_t type,
    #PointSetType_t ptset_type,
    #cgsize_t npnts, const cgsize_t * pnts, const char * donorname,
    #ZoneType_t donor_zonetype,
    #PointSetType_t donor_ptset_type,
    #DataType_t donor_datatype,
    #cgsize_t ndata_donor, const cgsize_t *donor_data, int *I);
@checked
def conn_write(int fn, int B, int Z, const char * connectname, GridLocation location,
    GridConnectivityType type, PointSetType ptset_type, cgsize_t npnts, np.ndarray pnts,
    const char * donorname, ZoneType donor_zonetype, PointSetType donor_ptset_type,
    DataType donor_datatype, cgsize_t ndata_donor, np.ndarray donor_data):
    cdef int I
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)
    donor_data_ptr = <cgsize_t *>np.PyArray_DATA(donor_data)
    return cg_conn_write(fn, B, Z, connectname, location, type, ptset_type, npnts, pnts_ptr, donorname,
                            donor_zonetype, donor_ptset_type, donor_datatype, ndata_donor, donor_data_ptr, &I), I

#int cg_conn_write_short(int file_number, int B, int Z,
    #const char * connectname, GridLocation_t location,
    #GridConnectivityType_t type,
    #PointSetType_t ptset_type,
    #cgsize_t npnts, const cgsize_t * pnts, const char * donorname, int *I);
@checked
def conn_write_short(int fn, int B, int Z, const char * connectname, GridLocation location,
    GridConnectivityType type, PointSetType ptset_type, cgsize_t npnts, np.ndarray pnts, const char * donorname):
    cdef int I
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)
    return cg_conn_write_short(fn, B, Z, connectname, location, type, ptset_type, npnts, pnts_ptr, donorname, &I), I

#int cg_conn_read_short(int file_number, int B, int Z, int I,
    #cgsize_t *pnts);
@checked
def conn_read_short(int fn, int B, int Z, int I):
    cdef int npnts
    _,_,_,_,npnts,*_ = conn_info(fn, B, Z, I)
    pnts = np.zeros((npnts,), dtype=np.int32, order='F')
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)
    return cg_conn_read_short(fn, B, Z, I, pnts_ptr), pnts


# Read and write GridConnectivity1to1_t Nodes in a zone

#int cg_n1to1(int fn, int B, int Z, int *n1to1);
@checked
def conn_n1to1(int fn, int B, int Z):
    cdef int n1to1
    return cg_n1to1(fn, B, Z, &n1to1), n1to1

#int cg_1to1_read(int fn, int B, int Z, int I, char *connectname,
    #char *donorname, cgsize_t *range, cgsize_t *donor_range, int *transform);
@checked
def conn_1to1_read(int fn, int B, int Z, int I):
    cdef char connectname[MAXNAMELENGTH]
    cdef char donorname[MAXNAMELENGTHEXTENDED]
    cdef cgsize_t * range_ptr
    cdef cgsize_t * donor_range_ptr
    cdef int * tr_ptr
    _range = np.ones((2,3), dtype=np.int32, order='F')
    range_ptr = <cgsize_t *>np.PyArray_DATA(_range)
    donor_range = np.ones((2,3), dtype=np.int32, order='F')
    donor_range_ptr = <cgsize_t *>np.PyArray_DATA(donor_range)
    transform = np.ones((3,), dtype=np.int32, order='F')
    transform_ptr=<int *>np.PyArray_DATA(transform)
    return (cg_1to1_read(fn, B, Z, I, connectname, donorname, range_ptr, donor_range_ptr, transform_ptr),
            connectname, donorname, _range, donor_range, transform)

#int cg_1to1_id(int fn, int B, int Z, int I, double *one21_id);
@checked
def conn_1to1_id(int fn, int B, int Z, int I):
    cdef double one21_id
    return cg_1to1_id(fn, B, Z, I, &one21_id), one21_id

#int cg_1to1_write(int fn, int B, int Z, const char * connectname,
    #const char * donorname, const cgsize_t * range,
    #const cgsize_t * donor_range, const int * transform, int *I);
@checked
def conn_1to1_write(int fn, int B, int Z, const char * connectname,
    const char * donorname, _range, donor_range, transform):
    cdef int I
    cdef cgsize_t * crange_ptr
    cdef cgsize_t * drange_ptr
    cdef int * trptr

    carray = np.int32(_range)
    darray = np.int32(donor_range)
    tarray = np.int32(transform)

    crange_ptr = <cgsize_t *>np.PyArray_DATA(carray)
    drange_ptr = <cgsize_t *>np.PyArray_DATA(darray)
    tr_ptr = <int *>np.PyArray_DATA(tarray)

    return cg_1to1_write(fn, B, Z, connectname, donorname,
                                      crange_ptr, drange_ptr, tr_ptr, &I), I


# Read all GridConnectivity1to1_t Nodes of a base

#int cg_n1to1_global(int fn, int B, int *n1to1_global);
@checked
def conn_n1to1_global(int fn, int B):
    cdef int n1to1_global
    return cg_n1to1_global(fn, B, &n1to1_global), n1to1_global

#int cg_1to1_read_global(int fn, int B, char **connectname,
    #char **zonename, char **donorname, cgsize_t **range,
    #cgsize_t **donor_range, int **transform);
@checked
def conn_1to1_read_global(int fn, int B):
    raise CGNSException(99, "not implemented")
#TODO NOT IMPLEMENTED


# Read and write GridConnectivityProperty_t/Periodic_t Nodes

#int cg_conn_periodic_read(int file_number, int B, int Z, int I,
    #float *RotationCenter, float *RotationAngle, float *Translation);
@checked
def conn_periodic_read(int fn, int B, int Z, int I):
    cdef cdim
    cdef np.ndarray RotationCenter, RotationAngle, Translation

    cdim = cell_dim(fn, B)
    RotationCenter = np.ones(cdim, dtype=np.float32, order='F')
    RotationAngle = np.ones(cdim, dtype=np.float32, order='F')
    Translation = np.ones(cdim, dtype=np.float32, order='F')
    return cg_conn_periodic_read(fn, B, Z, I, <float *>RotationCenter.data, <float *>RotationCenter.data,
                                     <float *>RotationCenter.data), RotationCenter, RotationAngle, Translation

#int cg_conn_periodic_write(int file_number, int B, int Z, int I,
    #float *const RotationCenter, float *const RotationAngle,
    #float *const Translation);
@checked
def conn_periodic_write(int fn, int B, int Z, int I, RotationCenter,
                        RotationAngle, Translation):
    nRotationCenter = np.asarray(RotationCenter, dtype=np.float32, order='F')
    nRotationAngle = np.asarray(RotationAngle, dtype=np.float32, order='F')
    nTranslation = np.asarray(Translation, dtype=np.float32, order='F')
    RotationCenter_ptr = <float *>np.PyArray_DATA(nRotationCenter)
    RotationAngle_ptr = <float *>np.PyArray_DATA(nRotationAngle)
    Translation_ptr = <float *>np.PyArray_DATA(nTranslation)
    return cg_conn_periodic_write(fn, B, Z, I, RotationCenter_ptr, RotationAngle_ptr, Translation_ptr)

#int cg_1to1_periodic_write(int file_number, int B, int Z, int I,
    #float *const RotationCenter, float *const RotationAngle,
    #float *const Translation);
@checked
def conn_1to1_periodic_write(int fn, int B, int Z, int I, RotationCenter,
                        RotationAngle, Translation):
                        
    nRotationCenter = np.asarray(RotationCenter, dtype=np.float32, order='F')
    nRotationAngle = np.asarray(RotationAngle, dtype=np.float32, order='F')
    nTranslation = np.asarray(Translation, dtype=np.float32, order='F')
    RotationCenter_ptr = <float *>np.PyArray_DATA(nRotationCenter)
    RotationAngle_ptr = <float *>np.PyArray_DATA(nRotationAngle)
    Translation_ptr = <float *>np.PyArray_DATA(nTranslation)
    return cg_1to1_periodic_write(fn, B, Z, I, RotationCenter_ptr, RotationAngle_ptr, Translation_ptr)

#int cg_1to1_periodic_read(int file_number, int B, int Z, int I,
    #float *RotationCenter, float *RotationAngle, float *Translation);
@checked
def conn_1to1_periodic_read(int fn, int B, int Z, int I):
    cdef cdim
    cdef np.ndarray RotationCenter, RotationAngle, Translation

    cdim = cell_dim(fn, B)
    RotationCenter = np.ones(cdim, dtype=np.float32, order='F')
    RotationAngle = np.ones(cdim, dtype=np.float32, order='F')
    Translation = np.ones(cdim, dtype=np.float32, order='F')
    return cg_1to1_periodic_read(fn, B, Z, I, <float *>RotationCenter.data, <float *>RotationCenter.data,
                                     <float *>RotationCenter.data), RotationCenter, RotationAngle, Translation

# Read and write GridConnectivityProperty_t/AverageInterface_t Nodes

#int cg_conn_average_read(int file_number, int B, int Z, int I,
    #AverageInterfaceType_t *AverageInterfaceType);
@checked
def conn_average_read(int fn, int B, int Z, int I):
    cdef AverageInterfaceType AverageInterfaceType
    return cg_conn_average_read(fn, B, Z, I, &AverageInterfaceType), AverageInterfaceType

#int cg_conn_average_write(int file_number, int B, int Z, int I,
    #AverageInterfaceType_t AverageInterfaceType);
@checked
def conn_average_write(int fn, int B, int Z, int I, AverageInterfaceType AverageInterfaceType):
    return cg_conn_average_write(fn, B, Z, I, AverageInterfaceType)

#int cg_1to1_average_write(int file_number, int B, int Z, int I,
    #AverageInterfaceType_t AverageInterfaceType);
@checked
def conn_1to1_average_write(int fn, int B, int Z, int I, AverageInterfaceType AverageInterfaceType):
    return cg_1to1_average_write(fn, B, Z, I, AverageInterfaceType)

#int cg_1to1_average_read(int file_number, int B, int Z, int I,
    #AverageInterfaceType_t *AverageInterfaceType);
@checked
def conn_1to1_average_read(int fn, int B, int Z, int I):
    cdef AverageInterfaceType AverageInterfaceType
    return cg_1to1_average_read(fn, B, Z, I, &AverageInterfaceType), AverageInterfaceType