# Read and write Elements_t Nodes

#int cg_nsections(int file_number, int B, int Z, int *nsections);
@checked
def nsections(int fn, int B, int Z):
    cdef int nsections
    return cg_nsections(fn, B, Z, &nsections), nsections

#int cg_section_read(int file_number, int B, int Z, int S,
    #char *SectionName,  ElementType_t *type,
    #cgsize_t *start, cgsize_t *end, int *nbndry, int *parent_flag);
@checked
def section_read(int fn, int B, int Z, int S):
    cdef char SectionName[MAXNAMELENGTH]
    cdef ElementType_t type
    cdef cgsize_t start
    cdef cgsize_t end
    cdef int nbndry
    cdef int parent_flag

    return (cg_section_read(fn, B, Z, S, SectionName, &type, &start, &end, &nbndry, &parent_flag),
            SectionName, type, start, end, nbndry, parent_flag)

#int cg_elements_read(int file_number, int B, int Z, int S,
    #cgsize_t *elements, cgsize_t *parent_data);
#TODO NOT IMPLEMENTED
#int cg_section_write(int file_number, int B, int Z,
    #const char * SectionName, ElementType_t type,
    #cgsize_t start, cgsize_t end, int nbndry, const cgsize_t * elements,
    #int *S);
#TODO NOT IMPLEMENTED
#int cg_parent_data_write(int file_number, int B, int Z, int S,
    #const cgsize_t * parent_data);
#TODO NOT IMPLEMENTED
#int cg_npe( ElementType_t type, int *npe);
#TODO NOT IMPLEMENTED
#int cg_ElementDataSize(int file_number, int B, int Z, int S,
    #cgsize_t *ElementDataSize);
#TODO NOT IMPLEMENTED

#int cg_section_partial_write(int file_number, int B, int Z,
    #const char * SectionName, ElementType_t type,
    #cgsize_t start, cgsize_t end, int nbndry, int *S);
#TODO NOT IMPLEMENTED
#int cg_elements_partial_write(int fn, int B, int Z, int S,
    #cgsize_t start, cgsize_t end, const cgsize_t *elements);
#TODO NOT IMPLEMENTED
#int cg_parent_data_partial_write(int fn, int B, int Z, int S,
    #cgsize_t start, cgsize_t end, const cgsize_t *ParentData);
#TODO NOT IMPLEMENTED
#int cg_elements_partial_read(int file_number, int B, int Z, int S,
    #cgsize_t start, cgsize_t end, cgsize_t *elements, cgsize_t *parent_data);
#TODO NOT IMPLEMENTED
#int cg_ElementPartialSize(int file_number, int B, int Z, int S,
    #cgsize_t start, cgsize_t end, cgsize_t *ElementDataSize);
#TODO NOT IMPLEMENTED