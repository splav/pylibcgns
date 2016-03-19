#
# LIBRARY FUNCTIONS
#

#int cg_is_cgns(const char *filename, int *file_type);
def is_cgns(filename, int file_type):
    return cg_is_cgns(filename, &file_type)

#int cg_open(const char * filename, int mode, int *fn);
@checked
def open(str filename, int mode):
    cdef int fn
    return cg_open(filename, mode, &fn), fn

#int cg_version(int fn, float *FileVersion);
@checked
def version(int fn):
    cdef float fv
    return cg_version(fn, &fv), fv

#int cg_precision(int fn, int *precision);
@checked
def precision(int fn):
    cdef int precision
    return cg_precision(fn, &precision), precision

#int cg_close(int fn);
@checked
def close(int fn):
    return cg_close(fn)

#int cg_save_as(int fn, const char *filename, int file_type,
    #int follow_links);
@checked
def save_as(int fn, filename, int file_type, int follow_links):
    return cg_save_as(fn, filename, file_type, follow_links)

#int cg_set_file_type(int file_type);
@checked
def set_file_type(int file_type):
    return cg_set_file_type(file_type)

#int cg_get_file_type(int fn, int *file_type);
@checked
def get_file_type(int fn):
    cdef int file_type
    return cg_get_file_type(fn, &file_type), file_type

#int cg_root_id(int fn, double *rootid);
@checked
def root_id(int fn):
    cdef double rootid
    return cg_root_id(fn, &rootid), rootid

#int cg_get_cgio(int fn, int *cgio_num);
@checked
def get_cgio(int fn):
    cdef int cgio_num
    return cg_get_cgio(fn, &cgio_num), cgio_num

#int cg_configure(int what, void *value);
@checked
def configure(int what, value):
    raise CGNSException(99, "not implemented")
#TODO NOT IMPLEMENTED

#int cg_error_handler(void (*)(int, char *));
@checked
def error_handler(handler):
    raise CGNSException(99, "not implemented")
#TODO NOT IMPLEMENTED

#int cg_set_compress(int compress);
@checked
def set_compress(int compress):
    return cg_set_compress(compress)

#int cg_get_compress(int *compress);
@checked
def get_compress():
    cdef int compress
    return cg_get_compress(&compress), compress

#int cg_set_path(const char *path);
@checked
def set_path(path):
    return cg_set_path(path)

#int cg_add_path(const char *path);
@checked
def add_path(path):
    return cg_add_path(path)
