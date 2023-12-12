CC ?= gcc

BINARY_PATH = bin

export COMPILE_FLAGS = -Wall -Wextra -Werror -pedantic -Wstrict-aliasing -Wunreachable-code -g
export COMPLEX_COMPILE_FLAGS = -DZESPOLONE
export REAL_COMPILE_FLAGS = -UZESPOLONE
export LINK_FLAGS =
export COMPLEX_LINK_FLAGS =
export REAL_LINK_FLAGS =

print-%: ; @echo $*=$($*)

LINK_FLAGS += $(foreach LIBRARY,$(LIBRARIES),-l$(LIBRARY))

CMD_PREFIX := @
ifeq ($(VERBOSE),true)
	CMD_PREFIX :=
endif

DIRECTORIES = $(shell find . -maxdepth 1 -type d ! -name . -printf "%f\n")

print-%: ; @echo $*=$($*)

all: $(DIRECTORIES:%=all-%)

all-%:
	@echo "Build $*"
	$(CMD_PREFIX)cd "$*" ;  (test -f "Makefile" && $(MAKE) --no-print-directory) || true
	@echo

clean: $(DIRECTORIES:%=clean-%)

clean-%:
	@echo "Cleaning $*"
	$(CMD_PREFIX)cd "$*" ; (test -f "Makefile" && $(MAKE) clean --no-print-directory) || true


install-%:
	@echo "Installing $*"
	$(CMD_PREFIX)cd "$*" ; (test -f "Makefile" && $(MAKE) install --no-print-directory) || true
