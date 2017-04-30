from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy as np

import platform

include_dirs = [np.get_include()]
library_dirs = []

ext_modules = [Extension("pylibcgns",
                     ["pylibcgns.pyx"],
                     language='c',
                     libraries=["cgns", "hdf5"],
                     library_dirs=library_dirs,
                     include_dirs=include_dirs,
                     )]

setup(
  name = 'pylibcgns',
  cmdclass = {'build_ext': build_ext},
  version='0.1.0',
  description='CGNS C-library wrapper',

  author='Aleksandrov Sergey',
  author_email='splavgm@gmail.com',

  url='https://github.com/splav/pylibcgns',
  download_url='https://github.com/splav/pylibcgns/archive/0.1.0.tar.gz',

  license='MIT',



  ext_modules = ext_modules
)
