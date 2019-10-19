# pylibcgns

## About

Python bindings for [CFD General Notation System (CGNS)](https://github.com/CGNS/CGNS) C-library.
[CGNS MID-level API](https://cgns.github.io/CGNS_docs_current/midlevel/index.html) is mapped 1-to-1.

## Installation

The package require NumPy, libCGNS and libHDF5. The building additionally requires CGNS library headers. The locations of these need to be specified in `setup.py` if not standard. Just make an appropriate changes for lists `include_dirs` & `library_dirs`. For example,
```
include_dirs = [np.get_include(), "/home/user/apps/cgns/include"]
library_dirs = ["/home/user/apps/cgns/lib", "/home/user/apps/hdf5/lib"]
```
Note, shortcuts like `~` in pathes (e.g. `~/apps/cgns/lib`) do not work.

The python package is then built and installed in a standart way, via the command
```
$ pip install --user .
```
for installation inside the home dir, or
```
# pip install .
```
for installation system-wide.

## Usage example
```
import pylibcgns as cg
f = cg.open("init.cgns", cg.READ)
base = 1
nzones = cg.nzones(f, base)
print(nzones)

# Zone
zi = 1 # 1-based zone index
zname, zsize = cg.zone_read(f,base, zi)

# Fields
sol = 1 # 1-based solution index
V = cg.field_read(f,base,zi,sol, 'VelocityX', np.float64, (1,1,1), zsize[0])
```