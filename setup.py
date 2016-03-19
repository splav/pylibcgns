from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

ext_modules = [Extension("pylibcgns",
                     ["pylibcgns.pyx"],
                     language='c',
                     libraries=["cgns", "hdf5"],
                     )]

setup(
  name = 'pylibcgns',
  cmdclass = {'build_ext': build_ext},
  version='0.0.2',

  author='Aleksandrov Sergey',
  author_email='splavgm@gmail.com',

  license='MIT',

  py_modules=["pylibcgns"],

  ext_modules = ext_modules
)
