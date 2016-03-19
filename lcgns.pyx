#=========================================================================
#  libCGNS - Python package for CFD General Notation System
#  libCGNS API v3.2
#=========================================================================

cdef extern from "cgnslib.h":

    ctypedef int    cgerr_t
    ctypedef int    cgint_t
    ctypedef int    cgsize_t
    ctypedef double cgid_t

    #
    # constants
    #

    # modes for cgns file
    enum:
        CG_MODE_READ   = 0
        CG_MODE_WRITE  = 1
        CG_MODE_MODIFY = 2
        CG_MODE_CLOSE  = 3

    # file types
    enum:
        CG_FILE_NONE  = 0
        CG_FILE_ADF   = 1
        CG_FILE_HDF5  = 2
        CG_FILE_ADF2  = 3
        CG_FILE_PHDF5 = 4

    # function return codes
    enum:
        CG_OK             = 0
        CG_ERROR          = 1
        CG_NODE_NOT_FOUND = 2
        CG_INCORRECT_PATH = 3
        CG_NO_INDEX_DIM   = 4

    # Null and UserDefined enums
    enum:
        CG_Null        = 0
        CG_UserDefined = 1

    # max goto depth
    enum:
        CG_MAX_GOTO_DEPTH = 20

    # configuration options
    enum:
        CG_CONFIG_ERROR     = 1
        CG_CONFIG_COMPRESS  = 2
        CG_CONFIG_SET_PATH  = 3
        CG_CONFIG_ADD_PATH  = 4
        CG_CONFIG_FILE_TYPE = 5

        CG_CONFIG_HDF5_COMPRESS = 201
        CG_CONFIG_HDF5_MPI_COMM = 202

    #
    # enums
    #

    # Dimensional Units

cpdef enum MassUnits:
        MassUnitsNull           =CG_Null,
        MassUnitsUserDefined    =CG_UserDefined,
        Kilogram    =2,
        Gram        =3,
        Slug        =4,
        PoundMass   =5

cpdef enum LengthUnits:
        LengthUnitsNull       =CG_Null,
        LengthUnitsUserDefined=CG_UserDefined,
        Meter                 =2,
        Centimeter            =3,
        Millimeter            =4,
        Foot                  =5,
        Inch                  =6

cpdef enum TimeUnits:
        TimeUnitsNull        =CG_Null,
        TimeUnitsUserDefined =CG_UserDefined,
        Second               =2

cpdef enum TemperatureUnits:
        TemperatureUnitsNull        =CG_Null,
        TemperatureUnitsUserDefined =CG_UserDefined,
        Kelvin                      =2,
        Celsius                     =3,
        Rankine                     =4,
        Fahrenheit                  =5

cpdef enum AngleUnits:
        AngleUnitsNull        =CG_Null,
        AngleUnitsUserDefined =CG_UserDefined,
        Degree                =2,
        Radian                =3

cpdef enum ElectricCurrentUnits:
        ElectricCurrentUnitsNull        =CG_Null,
        ElectricCurrentUnitsUserDefined =CG_UserDefined,
        Ampere                          =2,
        Abampere                        =3,
        Statampere                      =4,
        Edison                          =5,
        auCurrent                       =6

cpdef enum SubstanceAmountUnits:
        SubstanceAmountUnitsNull        =CG_Null,
        SubstanceAmountUnitsUserDefined =CG_UserDefined,
        Mole                            =2,
        Entities                        =3,
        StandardCubicFoot               =4,
        StandardCubicMeter              =5

cpdef enum LuminousIntensityUnits:
        LuminousIntensityUnitsNull        =CG_Null,
        LuminousIntensityUnitsUserDefined =CG_UserDefined,
        Candela     =2,
        Candle      =3,
        Carcel      =4,
        Hefner      =5,
        Violle      =6

    # Data Class

cpdef enum DataClass:
        DataClassNull                   =CG_Null,
        DataClassUserDefined            =CG_UserDefined,
        Dimensional                     =2,
        NormalizedByDimensional         =3,
        NormalizedByUnknownDimensional  =4,
        NondimensionalParameter         =5,
        DimensionlessConstant           =6

    # Grid Location

cpdef enum GridLocation:
        GridLocationNull            =CG_Null,
        GridLocationUserDefined     =CG_UserDefined,
        Vertex                      =2,
        CellCenter                  =3,
        FaceCenter                  =4,
        IFaceCenter                 =5,
        JFaceCenter                 =6,
        KFaceCenter                 =7,
        EdgeCenter                  =8

    # BCData Types: Can not add types and stay forward compatible

cpdef enum BCDataType:
        BCDataTypeNull  =CG_Null,
        BCDataTypeUserDefined  =CG_UserDefined,
        Dirichlet  =2,
        Neumann  =3

    # Grid Connectivity Types

cpdef enum GridConnectivityType:
        GridConnectivityTypeNull            =CG_Null,
        GridConnectivityTypeUserDefined     =CG_UserDefined,
        Overset                             =2,
        Abutting                            =3,
        Abutting1to1                        =4

    # Point Set Types: Can't add types and stay forward compatible

cpdef enum PointSetType:
        PointSetTypeNull            =CG_Null,
        PointSetTypeUserDefined     =CG_UserDefined,
        PointList                   =2,
        PointListDonor              =3,
        PointRange                  =4,
        PointRangeDonor             =5,
        ElementRange                =6,
        ElementList                 =7,
        CellListDonor               =8

    # Governing Equations and Physical Models Types

cpdef enum GoverningEquationsType:
        GoverningEquationsNull          =CG_Null,
        GoverningEquationsUserDefined   =CG_UserDefined,
        FullPotential                   =2,
        Euler                           =3,
        NSLaminar                       =4,
        NSTurbulent                     =5,
        NSLaminarIncompressible         =6,
        NSTurbulentIncompressible       =7

cpdef enum ModelType:
        ModelTypeNull               =CG_Null,
        ModelTypeUserDefined        =CG_UserDefined,
        Ideal                       =2,
        VanderWaals                 =3,
        Constant                    =4,
        PowerLaw                    =5,
        SutherlandLaw               =6,
        ConstantPrandtl             =7,
        EddyViscosity               =8,
        ReynoldsStress              =9,
        ReynoldsStressAlgebraic     =10,
        Algebraic_BaldwinLomax      =11,
        Algebraic_CebeciSmith       =12,
        HalfEquation_JohnsonKing    =13,
        OneEquation_BaldwinBarth    =14,
        OneEquation_SpalartAllmaras  =15,
        TwoEquation_JonesLaunder    =16,
        TwoEquation_MenterSST       =17,
        TwoEquation_Wilcox          =18,
        CaloricallyPerfect          =19,
        ThermallyPerfect            =20,
        ConstantDensity             =21,
        RedlichKwong                =22,
        Frozen                      =23,
        ThermalEquilib              =24,
        ThermalNonequilib           =25,
        ChemicalEquilibCurveFit     =26,
        ChemicalEquilibMinimization  =27,
        ChemicalNonequilib          =28,
        EMElectricField             =29,
        EMMagneticField             =30,
        EMConductivity              =31,
        Voltage                     =32,
        Interpolated                =33,
        Equilibrium_LinRessler      =34,
        Chemistry_LinRessler        =35

    # Boundary Condition Types

cpdef enum BCType:
        BCTypeNull              =CG_Null,
        BCTypeUserDefined       =CG_UserDefined,
        BCAxisymmetricWedge     =2,
        BCDegenerateLine        =3,
        BCDegeneratePoint       =4,
        BCDirichlet             =5,
        BCExtrapolate           =6,
        BCFarfield              =7,
        BCGeneral               =8,
        BCInflow                =9,
        BCInflowSubsonic        =10,
        BCInflowSupersonic      =11,
        BCNeumann               =12,
        BCOutflow               =13,
        BCOutflowSubsonic       =14,
        BCOutflowSupersonic     =15,
        BCSymmetryPlane         =16,
        BCSymmetryPolar         =17,
        BCTunnelInflow          =18,
        BCTunnelOutflow         =19,
        BCWall                  =20,
        BCWallInviscid          =21,
        BCWallViscous           =22,
        BCWallViscousHeatFlux   =23,
        BCWallViscousIsothermal  =24,
        FamilySpecified         =25

    # Data types:  Can not add data types and stay forward compatible

cpdef enum DataType:
        DataTypeNull            =CG_Null,
        DataTypeUserDefined     =CG_UserDefined,
        Integer                 =2,
        RealSingle              =3,
        RealDouble              =4,
        Character               =5,
        LongInteger             =6

    # Element types

cpdef enum ElementType:
        ElementTypeNull         =CG_Null,
        ElementTypeUserDefined  =CG_UserDefined,
        NODE        =2,
        BAR_2       =3,
        BAR_3       =4,
        TRI_3       =5,
        TRI_6       =6,
        QUAD_4      =7,
        QUAD_8      =8,
        QUAD_9      =9,
        TETRA_4     =10,
        TETRA_10    =11,
        PYRA_5      =12,
        PYRA_14     =13,
        PENTA_6     =14,
        PENTA_15    =15,
        PENTA_18    =16,
        HEXA_8      =17,
        HEXA_20     =18,
        HEXA_27     =19,
        MIXED       =20,
        PYRA_13     =21,
        NGON_n      =22,
        NFACE_n     =23,
        BAR_4       =24,
        TRI_9       =25,
        TRI_10      =26,
        QUAD_12     =27,
        QUAD_16     =28,
        TETRA_16    =29,
        TETRA_20    =30,
        PYRA_21     =31,
        PYRA_29     =32,
        PYRA_30     =33,
        PENTA_24    =34,
        PENTA_38    =35,
        PENTA_40    =36,
        HEXA_32     =37,
        HEXA_56     =38,
        HEXA_64     =39

cpdef enum:
            NPE_NODE      =1
cpdef enum:
            NPE_BAR_2     =2
cpdef enum:
            NPE_BAR_3     =3
cpdef enum:
            NPE_TRI_3     =3
cpdef enum:
            NPE_TRI_6     =6
cpdef enum:
            NPE_QUAD_4    =4
cpdef enum:
            NPE_QUAD_8    =8
cpdef enum:
            NPE_QUAD_9    =9
cpdef enum:
            NPE_TETRA_4   =4
cpdef enum:
            NPE_TETRA_10  =10
cpdef enum:
            NPE_PYRA_5    =5
cpdef enum:
            NPE_PYRA_13   =13
cpdef enum:
            NPE_PYRA_14   =14
cpdef enum:
            NPE_PENTA_6   =6
cpdef enum:
            NPE_PENTA_15  =15
cpdef enum:
            NPE_PENTA_18  =18
cpdef enum:
            NPE_HEXA_8    =8
cpdef enum:
            NPE_HEXA_20   =20
cpdef enum:
            NPE_HEXA_27   =27
cpdef enum:
            NPE_MIXED     =0
cpdef enum:
            NPE_NGON_n    =0
cpdef enum:
            NPE_NFACE_n   =0
cpdef enum:
            NPE_BAR_4     =4
cpdef enum:
            NPE_TRI_9     =9
cpdef enum:
            NPE_TRI_10    =10
cpdef enum:
            NPE_QUAD_12   =12
cpdef enum:
            NPE_QUAD_16   =16
cpdef enum:
            NPE_TETRA_16  =16
cpdef enum:
            NPE_TETRA_20  =20
cpdef enum:
            NPE_PYRA_21   =21
cpdef enum:
            NPE_PYRA_29   =29
cpdef enum:
            NPE_PYRA_30   =30
cpdef enum:
            NPE_PENTA_24  =24
cpdef enum:
            NPE_PENTA_38  =38
cpdef enum:
            NPE_PENTA_40  =40
cpdef enum:
            NPE_HEXA_32   =32
cpdef enum:
            NPE_HEXA_56   =56
cpdef enum:
            NPE_HEXA_64   =64


    # Zone types

cpdef enum ZoneType:
        ZoneTypeNull            =CG_Null,
        ZoneTypeUserDefined     =CG_UserDefined,
        Structured      =2,
        Unstructured    =3

    # Rigid Grid Motion types

cpdef enum RigidGridMotionType:
        RigidGridMotionTypeNull         =CG_Null,
        RigidGridMotionTypeUserDefined  =CG_UserDefined,
        ConstantRate  =2,
        VariableRate  =3

    # Arbitrary Grid Motion types

cpdef enum ArbitraryGridMotionType:
        ArbitraryGridMotionTypeNull         =CG_Null,
        ArbitraryGridMotionTypeUserDefined  =CG_UserDefined,
        NonDeformingGrid    =2,
        DeformingGrid       =3

    # Simulation types

cpdef enum SimulationType:
        SimulationTypeNull          =CG_Null,
        SimulationTypeUserDefined   =CG_UserDefined,
        TimeAccurate        =2,
        NonTimeAccurate     =3

    # BC Property types

cpdef enum WallFunctionType:
        WallFunctionTypeNull            =CG_Null,
        WallFunctionTypeUserDefined     =CG_UserDefined,
        Generic  =2

cpdef enum AreaType:
        AreaTypeNull            =CG_Null,
        AreaTypeUserDefined     =CG_UserDefined,
        BleedArea       =2,
        CaptureArea     =3

    # Grid Connectivity Property types

cpdef enum AverageInterfaceType:
        AverageInterfaceTypeNull            =CG_Null,
        AverageInterfaceTypeUserDefined     =CG_UserDefined,
        AverageAll              =2,
        AverageCircumferential  =3,
        AverageRadial           =4,
        AverageI                =5,
        AverageJ                =6,
        AverageK                =7

cdef extern from "cgnslib.h":
    #
    # LIBRARY FUNCTIONS
    #

    int cg_is_cgns(const char *filename, int *file_type);

    int cg_open(const char * filename, int mode, int *fn);
    int cg_version(int fn, float *FileVersion);
    int cg_precision(int fn, int *precision);
    int cg_close(int fn);
    int cg_save_as(int fn, const char *filename, int file_type,
        int follow_links);

    int cg_set_file_type(int file_type);
    int cg_get_file_type(int fn, int *file_type);
    int cg_root_id(int fn, double *rootid);
    int cg_get_cgio(int fn, int *cgio_num);

    int cg_configure(int what, void *value);

    int cg_error_handler(void (*)(int, char *));
    int cg_set_compress(int compress);
    int cg_get_compress(int *compress);
    int cg_set_path(const char *path);
    int cg_add_path(const char *path);

    # Read and write CGNSBase_t Nodes

    int cg_nbases(int fn, int *nbases);
    int cg_base_read(int file_number, int B, char *basename,
        int *cell_dim, int *phys_dim);
    int cg_base_id(int fn, int B, double *base_id);
    int cg_base_write(int file_number, const char * basename,
        int cell_dim, int phys_dim, int *B);

    int cg_cell_dim(int fn, int B, int *cell_dim);

    # Read and write Zone_t Nodes

    int cg_nzones(int fn, int B, int *nzones);
    int cg_zone_read(int fn, int B, int Z, char *zonename, cgsize_t *size);
    int cg_zone_type(int file_number, int B, int Z,
        ZoneType *type);
    int cg_zone_id(int fn, int B, int Z, double *zone_id);
    int cg_zone_write(int fn, int B, const char * zonename,
        const cgsize_t * size, ZoneType type, int *Z);

    int cg_index_dim(int fn, int B, int Z, int *index_dim);

    # Read and write Family_t Nodes

    int cg_nfamilies(int file_number, int B, int *nfamilies);
    int cg_family_read(int file_number, int B, int F,
        char *family_name, int *nboco, int *ngeos);
    int cg_family_write(int file_number, int B,
        const char * family_name, int *F);

    int cg_nfamily_names(int file_number, int B, int F, int *nnames);
    int cg_family_name_read(int file_number, int B, int F,
        int N, char *name, char *family);
    int cg_family_name_write(int file_number, int B, int F,
        const char *name, const char *family);

    # Read and write FamilyName_t Nodes

    int cg_famname_read(char *family_name);
    int cg_famname_write(const char * family_name);

    int cg_nmultifam(int *nfams);
    int cg_multifam_read(int N, char *name, char *family);
    int cg_multifam_write(const char *name, const char *family);

    # Read and write FamilyBC_t Nodes

    int cg_fambc_read(int file_number, int B, int F, int BC,
        char *fambc_name, BCType *bocotype);
    int cg_fambc_write(int file_number, int B, int F,
        const char * fambc_name, BCType bocotype, int *BC);

    # Read and write GeometryReference_t Nodes

    int cg_geo_read(int file_number, int B, int F, int G, char *geo_name,
        char **geo_file, char *CAD_name, int *npart);
    int cg_geo_write(int file_number, int B, int F, const char * geo_name,
        const char * filename, const char * CADname, int *G);

    # Read and write GeometryEntity_t Nodes

    int cg_part_read(int file_number, int B, int F, int G, int P,
        char *part_name);
    int cg_part_write(int file_number, int B, int F, int G,
        const char * part_name, int *P);

    # Read and write GridCoordinates_t Nodes

    int cg_ngrids(int file_number, int B, int Z, int *ngrids);
    int cg_grid_read(int file_number, int B, int Z, int G, char *gridname);
    int cg_grid_write(int file_number, int B, int Z,
        const char * zcoorname, int *G);

    # Read and write GridCoordinates_t/DataArray_t Nodes

    int cg_ncoords(int fn, int B, int Z, int *ncoords);
    int cg_coord_info(int fn, int B, int Z, int C,
        DataType *type, char *coordname);
    int cg_coord_read(int fn, int B, int Z, const char * coordname,
        DataType type, const cgsize_t * rmin,
        const cgsize_t * rmax, void *coord);
    int cg_coord_id(int fn, int B, int Z, int C, double *coord_id);
    int cg_coord_write(int fn, int B, int Z,
        DataType type, const char * coordname,
        const void * coord_ptr, int *C);

    int cg_coord_partial_write(int fn, int B, int Z,
        DataType type, const char * coordname,
        const cgsize_t *rmin, const cgsize_t *rmax,
        const void * coord_ptr, int *C);

    # Read and write Elements_t Nodes

    int cg_nsections(int file_number, int B, int Z, int *nsections);
    int cg_section_read(int file_number, int B, int Z, int S,
        char *SectionName,  ElementType *type,
        cgsize_t *start, cgsize_t *end, int *nbndry, int *parent_flag);
    int cg_elements_read(int file_number, int B, int Z, int S,
        cgsize_t *elements, cgsize_t *parent_data);
    int cg_section_write(int file_number, int B, int Z,
        const char * SectionName, ElementType type,
        cgsize_t start, cgsize_t end, int nbndry, const cgsize_t * elements,
        int *S);
    int cg_parent_data_write(int file_number, int B, int Z, int S,
        const cgsize_t * parent_data);
    int cg_npe( ElementType type, int *npe);
    int cg_ElementDataSize(int file_number, int B, int Z, int S,
        cgsize_t *ElementDataSize);

    int cg_section_partial_write(int file_number, int B, int Z,
        const char * SectionName, ElementType type,
        cgsize_t start, cgsize_t end, int nbndry, int *S);

    int cg_elements_partial_write(int fn, int B, int Z, int S,
        cgsize_t start, cgsize_t end, const cgsize_t *elements);

    int cg_parent_data_partial_write(int fn, int B, int Z, int S,
        cgsize_t start, cgsize_t end, const cgsize_t *ParentData);

    int cg_elements_partial_read(int file_number, int B, int Z, int S,
        cgsize_t start, cgsize_t end, cgsize_t *elements, cgsize_t *parent_data);

    int cg_ElementPartialSize(int file_number, int B, int Z, int S,
        cgsize_t start, cgsize_t end, cgsize_t *ElementDataSize);

    # Read and write FlowSolution_t Nodes

    int cg_nsols(int fn, int B, int Z, int *nsols);
    int cg_sol_info(int fn, int B, int Z, int S, char *solname,
        GridLocation *location);
    int cg_sol_id(int fn, int B, int Z,int S, double *sol_id);
    int cg_sol_write(int fn, int B, int Z, const char * solname,
        GridLocation location, int *S);
    int cg_sol_size(int fn, int B, int Z, int S,
        int *data_dim, cgsize_t *dim_vals);

    int cg_sol_ptset_info(int fn, int B, int Z, int S,
        PointSetType *ptset_type, cgsize_t *npnts);
    int cg_sol_ptset_read(int fn, int B, int Z, int S, cgsize_t *pnts);
    int cg_sol_ptset_write(int fn, int B, int Z, const char *solname,
        GridLocation location,
        PointSetType ptset_type, cgsize_t npnts,
        const cgsize_t *pnts, int *S);

    # Read and write solution DataArray_t Nodes

    int cg_nfields(int fn, int B, int Z, int S, int *nfields);
    int cg_field_info(int fn,int B,int Z,int S, int F,
        DataType *type, char *fieldname);
    int cg_field_read(int fn, int B, int Z, int S, const char *fieldname,
        DataType type, const cgsize_t *rmin,
            const cgsize_t *rmax, void *field_ptr);
    int cg_field_id(int fn, int B, int Z,int S, int F, double *field_id);
    int cg_field_write(int fn,int B,int Z,int S,
        DataType type, const char * fieldname,
        const void * field_ptr, int *F);

    int cg_field_partial_write(int fn, int B, int Z, int S,
        DataType type, const char * fieldname,
        const cgsize_t *rmin, const cgsize_t *rmax,
            const void * field_ptr, int *F);

    # Read and write ZoneSubRegion_t Nodes

    int cg_nsubregs(int fn, int B, int Z, int *nsubreg);
    int cg_subreg_info(int fn, int B, int Z, int S, char *regname,
        int *dimension, GridLocation *location,
        PointSetType *ptset_type, cgsize_t *npnts,
        int *bcname_len, int *gcname_len);
    int cg_subreg_ptset_read(int fn, int B, int Z, int S, cgsize_t *pnts);
    int cg_subreg_bcname_read(int fn, int B, int Z, int S, char *bcname);
    int cg_subreg_gcname_read(int fn, int B, int Z, int S, char *gcname);
    int cg_subreg_ptset_write(int fn, int B, int Z, const char *regname,
        int dimension, GridLocation location,
        PointSetType ptset_type, cgsize_t npnts,
        const cgsize_t *pnts, int *S);
    int cg_subreg_bcname_write(int fn, int B, int Z, const char *regname,
        int dimension, const char *bcname, int *S);
    int cg_subreg_gcname_write(int fn, int B, int Z, const char *regname,
        int dimension, const char *gcname, int *S);

    # Read and write ZoneGridConnectivity_t Nodes

    int cg_nzconns(int fn, int B, int Z, int *nzconns);
    int cg_zconn_read(int fn, int B, int Z, int C, char *name);
    int cg_zconn_write(int fn, int B, int Z, const char *name, int *C);
    int cg_zconn_get(int fn, int B, int Z, int *C);
    int cg_zconn_set(int fn, int B, int Z, int C);

    # Read and write OversetHoles_t Nodes

    int cg_nholes(int fn, int B, int Z, int *nholes);
    int cg_hole_info(int fn, int B, int Z, int I, char *holename,
        GridLocation *location,  PointSetType *ptset_type,
        int *nptsets, cgsize_t *npnts);
    int cg_hole_read(int fn, int B, int Z, int I, cgsize_t *pnts);
    int cg_hole_id(int fn, int B, int Z, int I, double *hole_id);
    int cg_hole_write(int fn, int B, int Z, const char * holename,
        GridLocation location, PointSetType ptset_type,
        int nptsets, cgsize_t npnts, const cgsize_t * pnts, int *I);

    # Read and write GridConnectivity_t Nodes

    int cg_nconns(int fn, int B, int Z, int *nconns);
    int cg_conn_info(int file_number, int B, int Z, int I,
        char *connectname, GridLocation *location,
        GridConnectivityType *type,
        PointSetType *ptset_type,
        cgsize_t *npnts, char *donorname,
        ZoneType *donor_zonetype,
        PointSetType *donor_ptset_type,
        DataType *donor_datatype,
        cgsize_t *ndata_donor);
    int cg_conn_read(int file_number, int B, int Z, int I, cgsize_t *pnts,
        DataType donor_datatype,
        cgsize_t *donor_data);
    int cg_conn_id(int fn, int B, int Z, int I, double *conn_id);
    int cg_conn_write(int file_number, int B, int Z,
        const char * connectname, GridLocation location,
        GridConnectivityType type,
        PointSetType ptset_type,
        cgsize_t npnts, const cgsize_t * pnts, const char * donorname,
        ZoneType donor_zonetype,
        PointSetType donor_ptset_type,
        DataType donor_datatype,
        cgsize_t ndata_donor, const cgsize_t *donor_data, int *I);
    int cg_conn_write_short(int file_number, int B, int Z,
        const char * connectname, GridLocation location,
        GridConnectivityType type,
        PointSetType ptset_type,
        cgsize_t npnts, const cgsize_t * pnts, const char * donorname, int *I);
    int cg_conn_read_short(int file_number, int B, int Z, int I,
        cgsize_t *pnts);

    # Read and write GridConnectivity1to1_t Nodes in a zone

    int cg_n1to1(int fn, int B, int Z, int *n1to1);
    int cg_1to1_read(int fn, int B, int Z, int I, char *connectname,
        char *donorname, cgsize_t *range, cgsize_t *donor_range, int *transform);
    int cg_1to1_id(int fn, int B, int Z, int I, double *one21_id);
    int cg_1to1_write(int fn, int B, int Z, const char * connectname,
        const char * donorname, const cgsize_t * range,
        const cgsize_t * donor_range, const int * transform, int *I);

    # Read all GridConnectivity1to1_t Nodes of a base

    int cg_n1to1_global(int fn, int B, int *n1to1_global);
    int cg_1to1_read_global(int fn, int B, char **connectname,
        char **zonename, char **donorname, cgsize_t **range,
        cgsize_t **donor_range, int **transform);

    # Read and write BC_t Nodes

    int cg_nbocos(int fn, int B, int Z, int *nbocos);
    int cg_boco_info(int fn, int B, int Z, int BC, char *boconame,
        BCType *bocotype, PointSetType *ptset_type,
        cgsize_t *npnts, int *NormalIndex, cgsize_t *NormalListSize,
        DataType *NormalDataType, int *ndataset);
    int cg_boco_read(int fn, int B, int Z, int BC, cgsize_t *pnts,
        void *NormalList);
    int cg_boco_id(int fn, int B, int Z, int BC, double *boco_id);
    int cg_boco_write(int file_number, int B, int Z, const char * boconame,
        BCType bocotype, PointSetType ptset_type,
        cgsize_t npnts, const cgsize_t * pnts, int *BC);
    int cg_boco_normal_write(int file_number, int B, int Z, int BC,
        const int * NormalIndex, int NormalListFlag,
        DataType NormalDataType, const void * NormalList);

    int cg_boco_gridlocation_read(int file_number, int B, int Z,
        int BC, GridLocation *location);
    int cg_boco_gridlocation_write(int file_number, int B, int Z,
        int BC, GridLocation location);

    # Read and write BCDataSet_t Nodes

    int cg_dataset_read(int fn, int B, int Z, int BC, int DS, char *name,
        BCType *BCType, int *DirichletFlag, int *NeumannFlag);
    int cg_dataset_write(int file_number, int B, int Z, int BC,
        const char * name, BCType BCType, int *Dset);

    # Read and write FamilyBCDataSet_t Nodes

    int cg_bcdataset_write(const char *name, BCType BCType,
        BCDataType BCDataType);
    int cg_bcdataset_info(int *n_dataset);
    int cg_bcdataset_read(int index, char *name,
        BCType *BCType, int *DirichletFlag, int *NeumannFlag);

    # Read and write BCData_t Nodes

    int cg_bcdata_write(int file_number, int B, int Z, int BC, int Dset,
        BCDataType BCDataType);

    # Read and write DiscreteData_t Nodes

    int cg_ndiscrete(int file_number, int B, int Z, int *ndiscrete);
    int cg_discrete_read(int file_number, int B, int Z, int D,
        char *discrete_name);
    int cg_discrete_write(int file_number, int B, int Z,
        const char * discrete_name, int *D);
    int cg_discrete_size(int fn, int B, int Z, int D,
        int *data_dim, cgsize_t *dim_vals);

    int cg_discrete_ptset_info(int fn, int B, int Z, int D,
        PointSetType *ptset_type, cgsize_t *npnts);
    int cg_discrete_ptset_read(int fn, int B, int Z, int D,
        cgsize_t *pnts);
    int cg_discrete_ptset_write(int fn, int B, int Z,
        const char *discrete_name, GridLocation location,
        PointSetType ptset_type, cgsize_t npnts,
        const cgsize_t *pnts, int *D);

    # Read and write RigidGridMotion_t Nodes

    int cg_n_rigid_motions(int file_number, int B, int Z,
        int *n_rigid_motions);
    int cg_rigid_motion_read(int file_number, int B, int Z, int R,
        char *name, RigidGridMotionType *type);
    int cg_rigid_motion_write(int file_number, int B, int Z,
        const char * name, RigidGridMotionType type, int *R);

    # Read and write ArbitraryGridMotion_t Nodes

    int cg_n_arbitrary_motions(int file_number, int B, int Z,
        int *n_arbitrary_motions);
    int cg_arbitrary_motion_read(int file_number, int B, int Z, int A,
        char *name, ArbitraryGridMotionType *type);
    int cg_arbitrary_motion_write(int file_number, int B, int Z,
        const char * amotionname, ArbitraryGridMotionType type,
        int *A);

    # Read and write SimulationType_t Node

    int cg_simulation_type_read(int file_number, int B,
        SimulationType *type);
    int cg_simulation_type_write(int file_number, int B,
        SimulationType type);

    # Read and write BaseIterativeData_t Node

    int cg_biter_read(int file_number, int B, char *bitername, int *nsteps);
    int cg_biter_write(int file_number, int B, const char * bitername, int nsteps);

    # Read and write ZoneIterativeData_t Node

    int cg_ziter_read(int file_number, int B, int Z, char *zitername);
    int cg_ziter_write(int file_number, int B, int Z, const char * zitername);

    # Read and write Gravity_t Nodes

    int cg_gravity_read(int file_number, int B, float *gravity_vector);
    int cg_gravity_write(int file_number, int B, float *const gravity_vector);

    # Read and write Axisymmetry_t Nodes

    int cg_axisym_read(int file_number, int B, float *ref_point,
        float *axis);
    int cg_axisym_write(int file_number, int B, float *const ref_point,
        float *const axis);

    # Read and write RotatingCoordinates_t Nodes

    int cg_rotating_read(float *rot_rate, float *rot_center);
    int cg_rotating_write(float *const rot_rate, float *const rot_center);

    # Read and write BCProperty_t/WallFunction_t Nodes

    int cg_bc_wallfunction_read(int file_number, int B, int Z, int BC,
        WallFunctionType *WallFunctionType);
    int cg_bc_wallfunction_write(int file_number, int B, int Z, int BC,
        WallFunctionType WallFunctionType);

    # Read and write BCProperty_t/Area_t Nodes

    int cg_bc_area_read(int file_number, int B, int Z, int BC,
        AreaType *AreaType, float *SurfaceArea, char *RegionName);
    int cg_bc_area_write(int file_number, int B, int Z, int BC,
        AreaType AreaType, float SurfaceArea, const char *RegionName);

    # Read and write GridConnectivityProperty_t/Periodic_t Nodes

    int cg_conn_periodic_read(int file_number, int B, int Z, int I,
        float *RotationCenter, float *RotationAngle, float *Translation);
    int cg_conn_periodic_write(int file_number, int B, int Z, int I,
        float *const RotationCenter, float *const RotationAngle,
        float *const Translation);
    int cg_1to1_periodic_write(int file_number, int B, int Z, int I,
        float *const RotationCenter, float *const RotationAngle,
        float *const Translation);
    int cg_1to1_periodic_read(int file_number, int B, int Z, int I,
        float *RotationCenter, float *RotationAngle, float *Translation);

    # Read and write GridConnectivityProperty_t/AverageInterface_t Nodes

    int cg_conn_average_read(int file_number, int B, int Z, int I,
        AverageInterfaceType *AverageInterfaceType);
    int cg_conn_average_write(int file_number, int B, int Z, int I,
        AverageInterfaceType AverageInterfaceType);
    int cg_1to1_average_write(int file_number, int B, int Z, int I,
        AverageInterfaceType AverageInterfaceType);
    int cg_1to1_average_read(int file_number, int B, int Z, int I,
        AverageInterfaceType *AverageInterfaceType);

    # Variable Argument List Functions

    int cg_goto(int file_number, int B, ...);
    int cg_gorel(int file_number, ...);
    int cg_gopath(int file_number, const char *path);
    int cg_golist(int file_number, int B, int depth, char **label,
        int *num);
    int cg_where(int *file_number, int *B, int *depth, char **label,
        int *num);

    # Read and write ConvergenceHistory_t Nodes

    int cg_convergence_read(int *iterations, char **NormDefinitions);
    int cg_convergence_write(int iterations, const char * NormDefinitions);

    # Read and write ReferenceState_t Nodes

    int cg_state_read(char **StateDescription);
    int cg_state_write(const char * StateDescription);

    # Read and write FlowEquationSet_t Nodes

    int cg_equationset_read(int *EquationDimension,
        int *GoverningEquationsFlag, int *GasModelFlag,
        int *ViscosityModelFlag,     int *ThermalConductivityModelFlag,
        int *TurbulenceClosureFlag,  int *TurbulenceModelFlag);
    int cg_equationset_chemistry_read(int *ThermalRelaxationFlag,
        int *ChemicalKineticsFlag);
    int cg_equationset_elecmagn_read(int *ElecFldModelFlag,
        int *MagnFldModelFlag, int *ConductivityModelFlag);
    int cg_equationset_write(int EquationDimension);

    # Read and write GoverningEquations_t Nodes

    int cg_governing_read(GoverningEquationsType *EquationsType);
    int cg_governing_write(GoverningEquationsType Equationstype);

    # Read and write Diffusion Model Nodes

    int cg_diffusion_read(int *diffusion_model);
    int cg_diffusion_write(const int * diffusion_model);

    # Read and write GasModel_t, ViscosityModel_t,
    # ThermalConductivityModel_t, TurbulenceClosure_t,
    # TurbulenceModel_t, ThermalRelaxationModel_t,
    # ChemicalKineticsModel_t, EMElectricFieldModel_t,
    # EMMagneticFieldModel_t Nodes

    int cg_model_read(const char *ModelLabel, ModelType *ModelType);
    int cg_model_write(const char * ModelLabel, ModelType ModelType);

    # Read and write DataArray_t Nodes

    int cg_narrays(int *narrays);
    int cg_array_info(int A, char *ArrayName,
        DataType *DataType,
        int *DataDimension, cgsize_t *DimensionVector);
    int cg_array_read(int A, void *Data);
    int cg_array_read_as(int A, DataType type, void *Data);
    int cg_array_write(const char * ArrayName,
        DataType DataType, int DataDimension,
        const cgsize_t * DimensionVector, const void * Data);

    # Read and write UserDefinedData_t Nodes - new in version 2.1

    int cg_nuser_data(int *nuser_data);
    int cg_user_data_read(int Index, char *user_data_name);
    int cg_user_data_write(const char * user_data_name);

    # Read and write IntegralData_t Nodes

    int cg_nintegrals(int *nintegrals);
    int cg_integral_read(int IntegralDataIndex, char *IntegralDataName);
    int cg_integral_write(const char * IntegralDataName);

    # Read and write Rind_t Nodes

    int cg_rind_read(int *RindData);
    int cg_rind_write(const int * RindData);

    # Read and write Descriptor_t Nodes

    int cg_ndescriptors(int *ndescriptors);
    int cg_descriptor_read(int descr_no, char *descr_name, char **descr_text);
    int cg_descriptor_write(const char * descr_name, const char * descr_text);

    # Read and write DimensionalUnits_t Nodes

    int cg_nunits(int *nunits);
    int cg_units_read     (MassUnits *mass,
            LengthUnits *length,
            TimeUnits *time,
            TemperatureUnits *temperature,
            AngleUnits *angle);
    int cg_units_write    (MassUnits mass,
            LengthUnits length,
            TimeUnits time,
            TemperatureUnits temperature,
            AngleUnits angle);
    int cg_unitsfull_read (MassUnits *mass,
            LengthUnits *length,
            TimeUnits *time,
            TemperatureUnits *temperature,
            AngleUnits *angle,
            ElectricCurrentUnits *current,
            SubstanceAmountUnits *amount,
            LuminousIntensityUnits *intensity);
    int cg_unitsfull_write(MassUnits mass,
            LengthUnits length,
            TimeUnits time,
            TemperatureUnits temperature,
            AngleUnits angle,
            ElectricCurrentUnits current,
            SubstanceAmountUnits amount,
            LuminousIntensityUnits intensity);

    # Read and write DimensionalExponents_t Nodes

    int cg_exponents_info(DataType *DataType);
    int cg_nexponents(int *numexp);
    int cg_exponents_read(void *exponents);
    int cg_exponents_write(DataType DataType, const void * exponents);
    int cg_expfull_read(void *exponents);
    int cg_expfull_write(DataType DataType, const void * exponents);

    # Read and write DataConversion_t Nodes

    int cg_conversion_info(DataType *DataType);
    int cg_conversion_read(void *ConversionFactors);
    int cg_conversion_write(DataType DataType, const void * ConversionFactors);

    # Read and write DataClass_t Nodes

    int cg_dataclass_read(DataClass *dataclass);
    int cg_dataclass_write(DataClass dataclass);

    # Read and write GridLocation_t Nodes

    int cg_gridlocation_read(GridLocation *GridLocation);
    int cg_gridlocation_write(GridLocation GridLocation);

    # Read and write Ordinal_t Nodes

    int cg_ordinal_read(int *Ordinal);
    int cg_ordinal_write(int Ordinal);

    # Read and write IndexArray/Range_t Nodes  - new in version 2.4

    int cg_ptset_info(PointSetType *ptset_type,
        cgsize_t *npnts);
    int cg_ptset_write(PointSetType ptset_type,
        cgsize_t npnts, const cgsize_t *pnts);
    int cg_ptset_read(cgsize_t *pnts);

    # Link Handling Functions - new in version 2.1

    int cg_is_link(int *path_length);
    int cg_link_read(char **filename, char **link_path);
    int cg_link_write(const char * nodename, const char * filename,
        const char * name_in_file);

    # General Delete Function

    int cg_delete_node(const char *node_name);

    # Free library malloced memory

    int cg_free(void *data);

    # Error Handling Functions

    const char *cg_get_error();
    void cg_error_exit();
    void cg_error_print();




import os.path
import numpy as np
cimport numpy as np

import inspect

# modes for cgns file
READ   = 0
WRITE  = 1
MODIFY = 2
CLOSE  = 3

# file types
NONE  = 0
ADF   = 1
HDF5  = 2
ADF2  = 3
PHDF5 = 4

# function return codes
OK             = 0
ERROR          = 1
NODE_NOT_FOUND = 2
INCORRECT_PATH = 3
NO_INDEX_DIM   = 4

# configuration options
ERROR     = 1
COMPRESS  = 2
SET_PATH  = 3
ADD_PATH  = 4
FILE_TYPE = 5

HDF5_COMPRESS = 201
HDF5_MPI_COMM = 202

ADF_MAX_DIMENSIONS = 12

class CGNSException(Exception):
    def __init__(self, code, msg):
        self.msg = msg
        self.code = code
    def __str__(self):
        return("pyCGNS Error: [%.4d] %s" % (self.code, self.msg))


cdef asCharPtrInList(char **ar, nstring, dstring):
    ns = []
    for n in range(nstring):
        ns.append(' '*dstring)
        ar[n] = <char *>ns[n]
    return ns

cdef fromCharPtrInList(char **ar, lstring):
    rlablist = []
    for n in range(len(lstring)):
        if len(ar[n].strip()) > 0:
            rlab = ar[n].strip()
            rlablist.append(rlab)
    return rlablist


from functools import wraps

def checked(func):
    @wraps(func)
    def with_checked(*args, **kwargs):
        res = func(*args, **kwargs)
        if isinstance(res, tuple):
            e, *res = res
            res = tuple(res) if len(res) > 1 else res[0]
        else:
            e, res = res, None
        if e:
            raise CGNSException(e, cg_get_error())
        return res

    return with_checked

include "lcgns_lib.pyx"
include "lcgns_base.pyx"
include "lcgns_zone.pyx"
#include "lcgns_family.pyx" #NOT IMPLEMENTED
##include "lcgns_geometry.pyx" #NOT IMPLEMENTED
include "lcgns_grid.pyx"
#include "lcgns_elements.pyx" #NOT IMPLEMENTED
include "lcgns_solution.pyx"
include "lcgns_subregion.pyx"
include "lcgns_connectivity.pyx" #PARTIALLY IMPLEMENTED
include "lcgns_boco.pyx"
include "lcgns_discrete.pyx"
include "lcgns_motion.pyx"
include "lcgns_aux.pyx"
include "lcgns_formulation.pyx"
include "lcgns_var.pyx"



# Read and write DimensionalUnits_t Nodes

#int cg_nunits(int *nunits);
@checked
def nunits():
    cdef int nunits
    return cg_nunits(&nunits), nunits

#int cg_units_read     (MassUnits_t *mass,
        #LengthUnits_t *length,
        #TimeUnits_t *time,
        #TemperatureUnits_t *temperature,
        #AngleUnits_t *angle);
@checked
def units_read():
        cdef MassUnits mass
        cdef LengthUnits length
        cdef TimeUnits time
        cdef TemperatureUnits temperature
        cdef AngleUnits angle
        return (cg_units_read(&mass, &length, &time, &temperature, &angle),
                    mass, length, time, temperature, angle)

#int cg_units_write    (MassUnits_t mass,
        #LengthUnits_t length,
        #TimeUnits_t time,
        #TemperatureUnits_t temperature,
        #AngleUnits_t angle);
@checked
def units_write(MassUnits mass, LengthUnits length, TimeUnits time,
        TemperatureUnits temperature, AngleUnits angle):
    return cg_units_write(mass, length, time, temperature, angle)

#int cg_unitsfull_read (MassUnits_t *mass,
        #LengthUnits_t *length,
        #TimeUnits_t *time,
        #TemperatureUnits_t *temperature,
        #AngleUnits_t *angle,
        #ElectricCurrentUnits_t *current,
        #SubstanceAmountUnits_t *amount,
        #LuminousIntensityUnits_t *intensity);
@checked
def unitsfull_read():
        cdef MassUnits mass
        cdef LengthUnits length
        cdef TimeUnits time
        cdef TemperatureUnits temperature
        cdef AngleUnits angle
        cdef ElectricCurrentUnits current
        cdef SubstanceAmountUnits amount
        cdef LuminousIntensityUnits intensity
        return (cg_unitsfull_read(&mass, &length, &time, &temperature, &angle,
                                     &current, &amount, &intensity),
                    mass, length, time, temperature, angle, current, amount, intensity)

#int cg_unitsfull_write(MassUnits_t mass,
        #LengthUnits_t length,
        #TimeUnits_t time,
        #TemperatureUnits_t temperature,
        #AngleUnits_t angle,
        #ElectricCurrentUnits_t current,
        #SubstanceAmountUnits_t amount,
        #LuminousIntensityUnits_t intensity);
@checked
def unitsfull_write(MassUnits mass, LengthUnits length,
        TimeUnits time, TemperatureUnits temperature,
        AngleUnits angle, ElectricCurrentUnits current,
        SubstanceAmountUnits amount, LuminousIntensityUnits intensity):
    return cg_unitsfull_write(mass, length, time, temperature, angle, current, amount, intensity)

# Read and write DimensionalExponents_t Nodes

#int cg_exponents_info(DataType_t *DataType);
@checked
def exponents_info():
    cdef DataType DataType
    return cg_exponents_info(&DataType), DataType

#int cg_nexponents(int *numexp);
@checked
def nexponents():
    cdef int numexp
    return cg_nexponents(&numexp), numexp

#int cg_exponents_read(void *exponents);
#int cg_exponents_write(DataType_t DataType, const void * exponents);
#int cg_expfull_read(void *exponents);
#int cg_expfull_write(DataType_t DataType, const void * exponents);

# Read and write DataConversion_t Nodes

#int cg_conversion_info(DataType_t *DataType);
#int cg_conversion_read(void *ConversionFactors);
#int cg_conversion_write(DataType_t DataType, const void * ConversionFactors);

# Read and write DataClass_t Nodes

#int cg_dataclass_read(DataClass_t *dataclass);
#int cg_dataclass_write(DataClass_t dataclass);

# Read and write GridLocation_t Nodes

#int cg_gridlocation_read(GridLocation_t *GridLocation);
#int cg_gridlocation_write(GridLocation_t GridLocation);

# Read and write Ordinal_t Nodes

#int cg_ordinal_read(int *Ordinal);
#int cg_ordinal_write(int Ordinal);

# Read and write IndexArray/Range_t Nodes  - new in version 2.4

#int cg_ptset_info(PointSetType_t *ptset_type,
    #cgsize_t *npnts);
#int cg_ptset_write(PointSetType_t ptset_type,
    #cgsize_t npnts, const cgsize_t *pnts);
#int cg_ptset_read(cgsize_t *pnts);



# Link Handling Functions - new in version 2.1

#int cg_is_link(int *path_length);
@checked
def is_link():
    cdef int path_length
    return cg_is_link(&path_length), path_length

#int cg_link_read(char **filename, char **link_path);
@checked
def link_read():
    cdef char *lfileptr = NULL
    cdef char *lpathptr = NULL
    err = cg_link_read(&lfileptr, &lpathptr)
    if not err:
        lf =str(lfileptr)
        lp =str(lpathptr)
        cg_free(lfileptr)
        cg_free(lpathptr)
    else:
        lf, lp = '', ''
    return err, lf, lp

#int cg_link_write(const char * nodename, const char * filename,
    #const char * name_in_file);
@checked
def link_write(const char * nodename, const char * filename,
        const char * name_in_file):
    return cg_link_write(nodename, filename, name_in_file)


# Variable Argument List Functions

#int cg_goto(int file_number, int B, ...);
@checked
def goto(int fn, int B, lpath):
    cdef int i0,i1,i2,i3,i4,i5,i6,i7,i8,i9
    cdef char *n0
    cdef char *n1
    cdef char *n2
    cdef char *n3
    cdef char *n4
    cdef char *n5
    cdef char *n6
    cdef char *n7
    cdef char *n8
    cdef char *n9
    cdef char *end
    depth = len(lpath)
    str_end = "end"
    end = <char *>str_end
    if depth == 0:
        return cg_goto(fn, B, end)
    n0, i0 = lpath[0]
    if depth == 1:
        return cg_goto(fn, B, n0, i0, end)
    n1, i1 = lpath[1]
    if depth==2:
      return cg_goto(fn, B, n0, i0, n1, i1, end)
    n2, i2 = lpath[2]
    if depth == 3:
        return cg_goto(fn, B, n0, i0, n1, i1, n2, i2, end)
    n3, i3 = lpath[3]
    if depth == 4:
        return cg_goto(fn, B, n0, i0, n1, i1, n2, i2, n3, i3, end)
    n4, i4 = lpath[4]
    if depth == 5:
        return cg_goto(fn, B, n0, i0, n1, i1, n2, i2, n3, i3, n4, i4, end)
    n5, i5 = lpath[5]
    if depth == 6:
        return cg_goto(fn, B, n0, i0, n1, i1, n2, i2, n3, i3, n4, i4, n5, i5, end)
    n6, i6 = lpath[6]
    if depth == 7:
        return cg_goto(fn, B, n0, i0, n1, i1, n2, i2, n3, i3, n4, i4, n5, i5, n6, i6, end)
    n7, i7 = lpath[7]
    if depth == 8:
        return cg_goto(fn, B, n0, i0, n1, i1, n2, i2, n3, i3, n4, i4, n5, i5, n6, i6, n7, i7, end)
    n8, i8 = lpath[8]
    if depth == 9:
        return cg_goto(fn, B, n0, i0, n1, i1, n2, i2, n3, i3, n4, i4, n5, i5, n6, i6, n7, i7, n8, i8, end)
    n9, i9 = lpath[9]
    if depth == 10:
        return cg_goto(fn, B, n0, i0, n1, i1, n2, i2, n3, i3, n4, i4, n5, i5, n6, i6, n7, i7, n8, i8, n9, i9, end)
    raise CGNSException(92,"goto depth larger than expected")

#int cg_gorel(int file_number, ...);
#TODO NOT IMPLEMENTED
#int cg_gopath(int file_number, const char *path);
#TODO NOT IMPLEMENTED
#int cg_golist(int file_number, int B, int depth, char **label,
    #int *num);
#TODO NOT IMPLEMENTED

#int cg_where(int *file_number, int *B, int *depth, char **label,
    #int *num);
@checked
def where():
    cdef int depth = 0
    cdef np.ndarray num
    cdef int *num_ptr
    cdef int B = 0
    cdef int fn = 0
    cdef char *lab[MAXGOTODEPTH]
    num = np.ones((MAXGOTODEPTH,), dtype=np.int32, order='F')
    num_ptr = <int *>num.data
    lablist = asCharPtrInList(lab, MAXGOTODEPTH, 32)
    err = cg_where(&fn, &B, &depth, lab, num_ptr)
    lablist = fromCharPtrInList(lab, lablist)
    rlab = []
    for i in range(depth):
      rlab.append((lablist[i], num[i]))
    return (err, fn, B, rlab)


# General Delete Function

#int cg_delete_node(const char *node_name);
@checked
def delete_node(const char *node_name):
    return cg_delete_node(node_name)

# Error Handling Functions

#const char *cg_get_error();
def get_error():
    return cg_get_error()
#void cg_error_exit();
def error_exit():
    cg_error_exit()
#void cg_error_print();
def error_print():
    cg_error_print()
# ------------------------------------------------------------

cpdef cg_open_(char *filename, int mode):
  cdef int fid
  fname = os.path.normpath(filename)
  fid = -1
  err = cg_open(filename, mode, &fid)
  return (fid, err)



cdef enum:
  MAXNAMELENGTH = 33
  MAXNAMELENGTHEXTENDED = 65
  MAXGOTODEPTH = 20
  MAXDIMENSIONS = 12

EMPTYSTRING=" "*MAXNAMELENGTH
DUMMYSTRING="/"*MAXNAMELENGTH

cdef asnumpydtype(DataType dtype):
    if (dtype==RealSingle):  return np.float32
    if (dtype==RealDouble):  return np.float64
    if (dtype==Integer):     return np.int32
    if (dtype==LongInteger): return np.int64
    if (dtype==Character):   return np.uint8
    return None

cdef fromnumpydtype(dtype):
    if (dtype.char=='f'):          return RealSingle
    if (dtype.char=='d'):          return RealDouble
    if (dtype.char=='i'):          return Integer
    if (dtype.char=='l'):          return LongInteger
    if (dtype.char in ['S','c']):  return Character
    return None


cdef struct ZoneSize2D:
    cgsize_t NVertexI, NVertexJ
    cgsize_t NCellI, NCellJ
    cgsize_t NBoundVertexI, NBoundVertexJ


cdef struct ZoneSize3D:
    cgsize_t NVertexI, NVertexJ, NVertexK
    cgsize_t NCellI, NCellJ, NCellK
    cgsize_t NBoundVertexI, NBoundVertexJ, NBoundVertexK

