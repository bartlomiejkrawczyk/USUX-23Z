LIBRARY_NAME := usux

CC ?= gcc
SOURCE_EXTENSION = c
SOURCE_PATH = .
LIBRARIES = m
INCLUDES = -I ../headers

COMPILE_FLAGS ?= -std=c99 -Wall -Wextra -Werror -pedantic -Wstrict-aliasing -Wunreachable-code -g
COMPLEX_COMPILE_FLAGS ?= -DZESPOLONE
REAL_COMPILE_FLAGS ?= -UZESPOLONE
LINK_FLAGS ?=
COMPLEX_LINK_FLAGS ?=
REAL_LINK_FLAGS ?=

print-%: ; @echo $*=$($*)

LINK_FLAGS += $(foreach LIBRARY,$(LIBRARIES),-l$(LIBRARY))

CMD_PREFIX := @
ifeq ($(VERBOSE),true)
	CMD_PREFIX :=
endif

build: complex

complex: export CFLAGS := $(CFLAGS) $(COMPILE_FLAGS) $(COMPLEX_COMPILE_FLAGS)
complex: export LDFLAGS := $(LDFLAGS) $(LINK_FLAGS) $(COMPLEX_LINK_FLAGS)
real: export CFLAGS := $(CFLAGS) $(COMPILE_FLAGS) $(REAL_COMPILE_FLAGS)
real: export LDFLAGS := $(LDFLAGS) $(LINK_FLAGS) $(REAL_LINK_FLAGS)

complex: export BUILD_PATH := build/complex
complex: export LIBRARY_PATH := lib/complex
real: export BUILD_PATH := build/real
real: export LIBRARY_PATH := lib/real

SOURCES = $(shell find $(SOURCE_PATH) -name '*.$(SOURCE_EXTENSION)' ! -name '$(MAIN_FILE)')

OBJECTS = $(SOURCES:$(SOURCE_PATH)/%.$(SOURCE_EXTENSION)=$(BUILD_PATH)/%.o)
DEPENDENCIES = $(OBJECTS:.o=.d)

-include $(DEPENDENCIES)

.PHONY: complex
complex: dirs
	@echo "Start complex numbers build"
	@$(MAKE) all --no-print-directory

.PHONY: real
real: dirs
	@echo "Start real numbers build"
	@$(MAKE) all --no-print-directory

.PHONY: dirs
dirs:
	@echo "Creating directories"
	@mkdir -p $(dir $(OBJECTS))
	@mkdir -p $(LIBRARY_PATH)

.PHONY: clean
clean:
	@echo "Deleting build and lib directories"
	$(CMD_PREFIX)$(RM) -r build
	$(CMD_PREFIX)$(RM) -r lib

.PHONY: install

$(BUILD_PATH)/%.o: $(SOURCE_PATH)/%.$(SOURCE_EXTENSION)
	@echo "Compiling: $< -> $@"
	$(CMD_PREFIX)$(CC) $(CFLAGS) $(INCLUDES) -MP -MMD -c $< -o $@

$(LIBRARY_PATH)/lib$(LIBRARY_NAME).a: $(OBJECTS)
	@echo "Making library: $(LIBRARY_PATH)/lib$(LIBRARY_NAME).a from: $^"
	$(CMD_PREFIX)$(AR) -rv $(LIBRARY_PATH)/lib$(LIBRARY_NAME).a $? 2>/dev/null

all: $(LIBRARY_PATH)/lib$(LIBRARY_NAME).a
