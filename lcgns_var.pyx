# Read and write DataArray_t Nodes

#int cg_narrays(int *narrays);
@checked
def narrays():
    cdef int narrays
    return cg_narrays(&narrays), narrays

#int cg_array_info(int A, char *ArrayName,
    #DataType_t *DataType,
    #int *DataDimension, cgsize_t *DimensionVector);
@checked
def array_info(int A):
    cdef char ArrayName[MAXNAMELENGTH]
    cdef DataType DataType
    cdef int DataDimension
    cdef cgsize_t *DimensionVector_ptr
    DimensionVector = np.zeros((ADF_MAX_DIMENSIONS,) ,dtype=np.int32, order='F')
    DimensionVector_ptr = <cgsize_t *>np.PyArray_DATA(DimensionVector)
    return (cg_array_info(A, ArrayName, &DataType, &DataDimension, DimensionVector_ptr),
                ArrayName, DataType, DataDimension, DimensionVector[0:DataDimension])

#int cg_array_read(int A, void *Data);
@checked
def array_read(int A):
    cdef np.ndarray adata
    _, dt, _, dv = array_info(A)

    if dt == Integer:
        adata = np.ones(tuple(dv), dtype=np.int32, order='F')
    if dt == LongInteger:
        adata = np.ones(tuple(dv), dtype=np.int64, order='F')
    if dt == RealSingle:
        adata = np.ones(tuple(dv), dtype=np.float32, order='F')
    if dt == RealDouble:
        adata = np.ones(tuple(dv), dtype=np.float64, order='F')
    if dt == Character:
        dim = np.prod(dv)
        adata = np.array((" "*dim))

    return cg_array_read(A, <void *>adata.data), adata

#int cg_array_read_as(int A, DataType_t type, void *Data);
#TODO NOT IMPLEMENTED

#int cg_array_write(const char * ArrayName,
    #DataType_t DataType, int DataDimension,
    #const cgsize_t * DimensionVector, const void * Data);
@checked
def array_write(const char * ArrayName, DataType DataType, int DataDimension,
        DimensionVector, np.ndarray Data):
    nDimensionVector = np.asarray(DimensionVector, dtype=np.int32, order='F')
    DimensionVector_ptr = <cgsize_t *>np.PyArray_DATA(nDimensionVector)
    return cg_array_write(ArrayName, DataType, DataDimension, DimensionVector_ptr, np.PyArray_DATA(Data))

# Read and write UserDefinedData_t Nodes - new in version 2.1

#int cg_nuser_data(int *nuser_data);
@checked
def nuser_data():
    cdef int nuser_data
    return cg_nuser_data(&nuser_data), nuser_data

#int cg_user_data_read(int Index, char *user_data_name);
def user_data_read(int Index):
    cdef char user_data_name[MAXNAMELENGTH]
    return cg_user_data_read(Index, user_data_name), user_data_name

#int cg_user_data_write(const char * user_data_name);
@checked
def user_data_write(const char * user_data_name):
    return cg_user_data_write(user_data_name)

# Read and write IntegralData_t Nodes

#int cg_nintegrals(int *nintegrals);
@checked
def nintegrals():
    cdef int nintegrals
    return cg_nintegrals(&nintegrals), nintegrals

#int cg_integral_read(int IntegralDataIndex, char *IntegralDataName);
@checked
def integral_read(int IntegralDataIndex):
    cdef char IntegralDataName[MAXNAMELENGTH]
    return cg_integral_read(IntegralDataIndex, IntegralDataName), IntegralDataName

#int cg_integral_write(const char * IntegralDataName);
@checked
def integral_write(const char * IntegralDataName):
    return cg_integral_write(IntegralDataName)

# Read and write Rind_t Nodes

#int cg_rind_read(int *RindData);
@checked
def rind_read():
    cdef np.ndarray rind
    cdef int *rind_ptr
    cdef int cdim
    fn, B, rlab = where()
    Z = rlab[0][1]
    ztype = zone_type(fn, B, Z)
    if ztype == Unstructured:
        cdim = 1
    elif ztype == Structured:
        _,cdim,_ = base_read(fn, B)
    else:
        raise CGNSException(98, "unknown zone type")
    rind = np.zeros((cdim*2,), dtype=np.int32, order='F') #TODO WHY*2?
    rind_ptr = <int *>rind.data
    return cg_rind_read(rind_ptr), rind

#int cg_rind_write(const int * RindData);
@checked
def rind_write(np.ndarray RindData):
    cdef np.ndarray arind = np.asarray(RindData, dtype=np.int32, order='F')
    return cg_rind_write(<int *>arind.data)

# Read and write Descriptor_t Nodes

#int cg_ndescriptors(int *ndescriptors);
@checked
def ndescriptors():
    cdef int ndescriptors
    return cg_ndescriptors(&ndescriptors), ndescriptors

#int cg_descriptor_read(int descr_no, char *descr_name, char **descr_text);
@checked
def descriptor_read(int descr_no):
    cdef char descr_name[MAXNAMELENGTH]
    cdef char *d_ptr = NULL

    err = cg_descriptor_read(descr_no, descr_name, &d_ptr)
    if not err:
        descr_text = str(d_ptr)
        cg_free(d_ptr)
    else:
        descr_text = ''

    return err, descr_name, descr_text


#int cg_descriptor_write(const char * descr_name, const char * descr_text);
@checked
def descriptor_write(const char * descr_name, const char * descr_text):
    return cg_descriptor_write(descr_name, descr_text)