# Author: Varun Hiremath <vh63@cornell.edu>
# Last Modified: Tue Jan 20 09:37:26 CET 2015

include ../build-files/vars.mk

ISATAB_PATH=../isatab_ser

EX_PATH="/scratch/user/pokharel_sagar/builds/cantera/installed/usr/local/include" # for ptr.h
IFLAGS = -I$(ISATAB_PATH) -I$(CANTERA_INCPATH)  -I$(EX_PATH) -I$(CANTERA_SRC)

LIB_NAME = libct

LDFLAGS = -L$(CANTERA_LIBPATH) -lcantera_fortran -lcantera -lpthread -lstdc++ 

# ------------- OBJECTS --------------------

include SOURCES.mk

OBJS=$(FILESf90:.f90=.$(OBJ)) $(FILEScpp:.cpp=.$(OBJ)) $(FILESf:.f=.$(OBJ))

# ------------- TARGETS --------------------

all: $(FILES) BUILD-ISATAB $(CREATE_LIBS)

BUILD-ISATAB:
	(cd $(ISATAB_PATH); $(MAKE))
	touch $@

include ../build-files/build-targets.mk

clean::
	$(RM) BUILD-ISATAB
