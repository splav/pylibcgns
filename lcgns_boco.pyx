# Read and write BC_t Nodes

#int cg_nbocos(int fn, int B, int Z, int *nbocos);
@checked
def nbocos(int fn, int B, int Z):
    cdef int nbocos
    return cg_nbocos(fn, B, Z, &nbocos), nbocos

#int cg_boco_info(int fn, int B, int Z, int BC, char *boconame,
    #BCType_t *bocotype, PointSetType_t *ptset_type,
    #cgsize_t *npnts, int *NormalIndex, cgsize_t *NormalListSize,
    #DataType_t *NormalDataType, int *ndataset);
@checked
def boco_info(int fn, int B, int Z, int BC):
    cdef char boconame[MAXNAMELENGTH]
    cdef BCType bocotype
    cdef PointSetType ptset_type
    cdef cgsize_t npnts
    cdef int NormalIndex,
    cdef cgsize_t NormalListSize
    cdef DataType NormalDataType
    cdef int ndataset

    return (cg_boco_info(fn, B, Z, BC, boconame, &bocotype, &ptset_type, &npnts,
                           &NormalIndex, &NormalListSize, &NormalDataType, &ndataset),
                boconame, bocotype, ptset_type, npnts, NormalIndex, NormalListSize, NormalDataType, ndataset)

#int cg_boco_read(int fn, int B, int Z, int BC, cgsize_t *pnts,
    #void *NormalList);
@checked
def boco_read(int fn, int B, int Z, int BC):
    cdef void* nl_ptr
    cdef cgsize_t* pnts_ptr

    *_,npnts,_,NormalListSize,NormalDataType,_ = boco_info(fn, B, Z, BC)

    ztype = zone_type(fn, B, Z)

    _, cdim, pdim = base_read(fn, B)
    if ztype == Unstructured:
        dim = 1
    elif ztype == Structured:
        dim = cdim
    else:
        raise CGNSException(0, "unknown zone type")

    pnts = np.zeros((npnts,dim), dtype=np.int32)
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)

    if NormalListSize == 0:
      nl = None
      nl_ptr = NULL
    else:
      if NormalDataType == RealDouble:
        nl = np.ones((NormalListSize/pdim,pdim), dtype=np.float64, order='F')
        nl_ptr = np.PyArray_DATA(nl)
      else:
        nl = np.ones((NormalListSize/pdim,pdim), dtype=np.float32, order='F')
        nl_ptr = np.PyArray_DATA(nl)

    return cg_boco_read(fn, B, Z, BC, pnts_ptr, nl_ptr), pnts, nl


#int cg_boco_id(int fn, int B, int Z, int BC, double *boco_id);
@checked
def boco_id(int fn, int B, int Z, int BC):
    cdef double boco_id
    return cg_boco_id(fn, B, Z, BC, &boco_id), boco_id

#int cg_boco_write(int file_number, int B, int Z, const char * boconame,
    #BCType_t bocotype, PointSetType_t ptset_type,
    #cgsize_t npnts, const cgsize_t * pnts, int *BC);
@checked
def boco_write(int fn, int B, int Z, const char * boconame, BCType bocotype, PointSetType ptset_type,
        cgsize_t npnts, np.ndarray pnts):
    cdef int BC
    pnts_ptr = <cgsize_t *>np.PyArray_DATA(pnts)
    return cg_boco_write(fn, B, Z, boconame, bocotype, ptset_type, npnts, pnts_ptr, &BC), BC

#int cg_boco_normal_write(int file_number, int B, int Z, int BC,
    #const int * NormalIndex, int NormalListFlag,
    #DataType_t NormalDataType, const void * NormalList);
@checked
def boco_normal_write(int fn, int B, int Z, int BC, np.ndarray NormalIndex, int NormalListFlag,
        DataType NormalDataType, np.ndarray NormalList):
    _, cdim, _ = base_read(fn, B)
    NormalList_ptr = np.PyArray_DATA(NormalList)
    nNormalIndex = np.asarray(NormalIndex, dtype=np.int32, order='F')
    NormalIndex_ptr = <int *>np.PyArray_DATA(nNormalIndex)
    return cg_boco_normal_write(fn, B, Z, BC, NormalIndex_ptr, NormalListFlag, NormalDataType, NormalList_ptr)

#int cg_boco_gridlocation_read(int file_number, int B, int Z,
    #int BC, GridLocation_t *location);
@checked
def boco_gridlocation_read(int fn, int B, int Z, int BC):
    cdef GridLocation location
    return cg_boco_gridlocation_read(fn, B, Z, BC, &location), location

#int cg_boco_gridlocation_write(int file_number, int B, int Z,
    #int BC, GridLocation_t location);
@checked
def boco_gridlocation_write(int fn, int B, int Z, int BC, GridLocation location):
    return cg_boco_gridlocation_write(fn, B, Z, BC, location)


# Read and write BCDataSet_t Nodes

#int cg_dataset_read(int fn, int B, int Z, int BC, int DS, char *name,
    #BCType_t *BCType, int *DirichletFlag, int *NeumannFlag);
@checked
def dataset_read(int fn, int B, int Z, int BC, int Dset):
    cdef char name[MAXNAMELENGTH]
    cdef BCType BCType
    cdef int DirichletFlag
    cdef int NeumannFlag
    return (cg_dataset_read(fn, B, Z, BC, Dset, name, &BCType, &DirichletFlag, &NeumannFlag),
                name, BCType, DirichletFlag, NeumannFlag)

#int cg_dataset_write(int file_number, int B, int Z, int BC,
    #const char * name, BCType_t BCType, int *Dset);
@checked
def dataset_write(int fn, int B, int Z, int BC,
    const char * name, BCType BCType):
    cdef int Dset
    return cg_dataset_write(fn, B, Z, BC, name, BCType, &Dset), Dset


# Read and write FamilyBCDataSet_t Nodes

#int cg_bcdataset_write(const char *name, BCType_t BCType,
    #BCDataType_t BCDataType);
@checked
def bcdataset_write(const char *name, BCType BCType, BCDataType BCDataType):
    return cg_bcdataset_write(name, BCType, BCDataType)

#int cg_bcdataset_info(int *n_dataset);
@checked
def bcdataset_info():
    cdef int n_dataset
    return cg_bcdataset_info(&n_dataset), n_dataset

#int cg_bcdataset_read(int index, char *name,
    #BCType_t *BCType, int *DirichletFlag, int *NeumannFlag);
@checked
def bcdataset_read(int Dset):
    cdef char name[MAXNAMELENGTH]
    cdef BCType BCType
    cdef int DirichletFlag
    cdef int NeumannFlag
    return cg_bcdataset_read(Dset, name, &BCType, &DirichletFlag, &NeumannFlag), BCType, DirichletFlag, NeumannFlag

# Read and write BCData_t Nodes

#int cg_bcdata_write(int file_number, int B, int Z, int BC, int Dset,
    #BCDataType_t BCDataType);
@checked
def bcdata_write(int fn, int B, int Z, int BC, int Dset, BCDataType BCDataType):
    return cg_bcdata_write(fn, B, Z, BC, Dset, BCDataType)


# Read and write BCProperty_t/WallFunction_t Nodes

#int cg_bc_wallfunction_read(int file_number, int B, int Z, int BC,
    #WallFunctionType_t *WallFunctionType);
@checked
def bc_wallfunction_read(int fn, int B, int Z, int BC):
    cdef WallFunctionType WallFunctionType
    return cg_bc_wallfunction_read(fn, B, Z, BC, &WallFunctionType), WallFunctionType

#int cg_bc_wallfunction_write(int file_number, int B, int Z, int BC,
    #WallFunctionType_t WallFunctionType);
@checked
def bc_wallfunction_write(int fn, int B, int Z, int BC, WallFunctionType WallFunctionType):
    return cg_bc_wallfunction_write(fn, B, Z, BC, WallFunctionType)

# Read and write BCProperty_t/Area_t Nodes

#int cg_bc_area_read(int file_number, int B, int Z, int BC,
    #AreaType_t *AreaType, float *SurfaceArea, char *RegionName);
@checked
def bc_area_read(int fn, int B, int Z, int BC):
    cdef AreaType AreaType
    cdef float SurfaceArea
    cdef char RegionName[MAXNAMELENGTH]
    return cg_bc_area_read(fn, B, Z, BC, &AreaType, &SurfaceArea, RegionName), AreaType, SurfaceArea, RegionName

#int cg_bc_area_write(int file_number, int B, int Z, int BC,
    #AreaType_t AreaType, float SurfaceArea, const char *RegionName);
@checked
def bc_area_write(int fn, int B, int Z, int BC, AreaType AreaType, float SurfaceArea, const char *RegionName):
    return cg_bc_area_write(fn, B, Z, BC, AreaType, SurfaceArea, RegionName)