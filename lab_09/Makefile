CC ?= gcc

CMD_PREFIX := @
ifeq ($(VERBOSE),true)
	CMD_PREFIX :=
endif

DIRECTORIES = $(shell find . -maxdepth 1 -type d ! -name . -printf "%f\n")

print-%: ; @echo $*=$($*)

all: $(DIRECTORIES:%=all-%)

all-%:
	$(CMD_PREFIX)echo "Build $*"
	$(CMD_PREFIX)cd "$*" ; $(MAKE) --no-print-directory

clean: $(DIRECTORIES:%=clean-%)

clean-%:
	$(CMD_PREFIX)echo "Cleaning $*"
	$(CMD_PREFIX)cd "$*" ; $(MAKE) clean --no-print-directory
