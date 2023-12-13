CC ?= gcc

INSTALL_PATH = bin

export COMPILE_FLAGS = -Wall -Wextra -Werror -pedantic -Wstrict-aliasing -Wunreachable-code -g
export COMPLEX_COMPILE_FLAGS = -DZESPOLONE
export REAL_COMPILE_FLAGS = -UZESPOLONE
export LINK_FLAGS =
export COMPLEX_LINK_FLAGS =
export REAL_LINK_FLAGS =

export INSTALL_PATH := $(shell realpath $(INSTALL_PATH))

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
	$(CMD_PREFIX)cd "$*" ;  \
	(test -f "Makefile" \
		&& echo "Build $*" \
		&& $(MAKE) --no-print-directory \
		&& (echo) \
	) || true

complex: $(DIRECTORIES:%=complex-%)

complex-%:
	$(CMD_PREFIX)cd "$*" ;  \
	(test -f "Makefile" \
		&& echo "Build complex $*" \
		&& $(MAKE) complex --no-print-directory \
		&& (echo) \
	) || true

real: $(DIRECTORIES:%=real-%)

real-%:
	$(CMD_PREFIX)cd "$*" ;  \
	(test -f "Makefile" \
		&& echo "Build real $*" \
		&& $(MAKE) real --no-print-directory \
		&& (echo) \
	) || true

clean: $(DIRECTORIES:%=clean-%)

clean-%:
	$(CMD_PREFIX)cd "$*" ; \
	(test -f "Makefile" \
		&& echo "Cleaning $*" \
		&& $(MAKE) clean --no-print-directory \
		&& (echo) \
	) || true

install: $(INSTALL_PATH) $(DIRECTORIES:%=install-%)

$(INSTALL_PATH):
	@mkdir -p $(INSTALL_PATH)

install-%:
	$(CMD_PREFIX)cd "$*" ; \
	(test -f "Makefile" \
		&& echo "Installing $*" \
		&&  $(MAKE) install --no-print-directory \
		&& (echo) \
	) || true
