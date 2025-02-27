# Author: Varun Hiremath <vh63@cornell.edu>
# Date: Thu, 29 Nov 2012 14:39:20 -0600

# intel compiler is used for building, ensure intel and mkl modules are loaded:
# -> Lonestar (intel is default): module load mkl
# -> Kraken: module load PrgEnv-intel
# Ranger use 'mpif90' wrapper; and on Kraken use 'ftn'

FC = mpif90
LINK_SYS_LIBS = -Bdynamic
CPP = g++

#ifeq ($(shell which mpif90 &> /dev/null; echo $$?), 0)
#        FC = f95
#        LINK_SYS_LIBS = -Bdynamic
#endif

CANTERA_LIBPATH=/scratch/user/pokharel_sagar/builds/cantera/installed/usr/local/lib
CANTERA_INCPATH=/scratch/user/pokharel_sagar/builds/cantera/installed/usr/local/include/cantera
CANTERA_SRC=/scratch/user/pokharel_sagar/builds/cantera/src # Needed for Cabinet.h

CPPFLAGS= -O3 -fPIC

# set debug/optimize modes
ifeq ($(BUILD_TYPE), debug)
	FCFLAGS = -fp-stack-check -traceback -g -debug all -debug-parameters all -fPIC -vec-report0 -DDEBUG -D_DEBUG
else
	FCFLAGS = -O2 -fPIC
endif

#  -ftree-vectorizer-verbose=1

LINK_LIBS = -Bdynamic -L/usr/local/lib -lcantera_fortran -lcantera -lpthread -lstdc++

# for Intel 11.1 with MKL 10.2, linking to MKL requires just one option:

#MKL_LIST = -mkl

# the -mkl option is equivalent to the following set of flags to ifort:
#MKL_LIST = -L${TACC_MKL_LIB} -lmkl_solver_lp64 -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_core -liomp5
# (Ref.: software.intel.com/en-us/articles/using-mkl-in-intel-compiler-mkl-qmkl-options)
# if -mkl doesn't work on your cluster, uncomment the above line, replacing
# ${TACC_MKL_LIB} with the appropriate MKL path for your cluster
# ...alternatively, uncomment the following line to use the hand-built lapack:
MKL_LIST = -L/usr/lib -llapack 

LN = ln -s
CP = cp
RM = rm -f
RMDIR = rm -rf
AR = ar crs
OBJ = o
MAKE=make BUILD_TYPE=$(BUILD_TYPE)
CREATE_LIBS = $(LIB_NAME).a $(LIB_NAME).so
