from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy as np

include_dirs = [np.get_include()]
library_dirs = []

#conda include path support
import os
if 'PREFIX' in os.environ:
    sys_include = os.path.join(os.environ['PREFIX'], 'include')
    print(sys_include)
    include_dirs += [sys_include]

ext_modules = [Extension("pylibcgns",
                     ["pylibcgns.pyx"],
                     language='c',
                     libraries=["cgns", "hdf5", "z"],
                     library_dirs=library_dirs,
                     include_dirs=include_dirs,
                     )]

setup(
  name = 'pylibcgns',
  cmdclass = {'build_ext': build_ext},
  version='0.1.1a',
  description='CGNS C-library wrapper',

  author='Aleksandrov Sergey',
  author_email='splavgm@gmail.com',

  url='https://github.com/splav/pylibcgns',
  download_url='https://github.com/splav/pylibcgns/archive/0.1.1a.tar.gz',

  license='MIT',

  ext_modules = ext_modules
)
