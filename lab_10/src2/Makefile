BINARY_NAME := prog_2
LIBRARY_NAME := usux
INSTALL_PATH ?= install

CC ?= gcc
SOURCE_EXTENSION = c
SOURCE_PATH = .
LIBRARIES = m
INCLUDES = -I ../headers
LIBRARY_SRC_PATH := ../lib

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

CFLAGS ?= $(COMPILE_FLAGS) $(COMPLEX_COMPILE_FLAGS)
LDFLAGS ?= $(LINK_FLAGS) $(COMPLEX_LINK_FLAGS)
real: export CFLAGS := $(CFLAGS) $(COMPILE_FLAGS) $(REAL_COMPILE_FLAGS)
real: export LDFLAGS := $(LDFLAGS) $(LINK_FLAGS) $(REAL_LINK_FLAGS)

BUILD_TYPE ?= complex
BUILD_PATH ?= build/complex
BINARY_PATH ?= bin/complex
LIBRARY_PATH ?= $(LIBRARY_SRC_PATH)/lib/complex
real: export BUILD_TYPE := real
real: export BUILD_PATH := build/real
real: export BINARY_PATH := bin/real
real: export LIBRARY_PATH := $(LIBRARY_SRC_PATH)/lib/real

SOURCES = $(shell find $(SOURCE_PATH) -name '*.$(SOURCE_EXTENSION)')

OBJECTS = $(SOURCES:$(SOURCE_PATH)/%.$(SOURCE_EXTENSION)=$(BUILD_PATH)/%.o)
DEPENDENCIES = $(OBJECTS:.o=.d)

-include $(DEPENDENCIES)

.PHONY: complex
complex:
	@echo "Start complex numbers build"
	@$(MAKE) all --no-print-directory

.PHONY: real
real:
	@echo "Start real numbers build"
	@$(MAKE) all --no-print-directory

.PHONY: dirs
dirs:
	@echo "Creating directories"
	@mkdir -p $(dir $(OBJECTS))
	@mkdir -p $(BINARY_PATH)

.PHONY: clean
clean:
	@echo "Deleting $(BINARY_NAME) symlink"
	@$(RM) $(BINARY_NAME)
	@echo "Deleting build and bin directories"
	@$(RM) -r build
	@$(RM) -r bin
	@$(RM) -r $(INSTALL_PATH)

.PHONY: install
install: all
	@echo "Installing $(BINARY_NAME)"
	@mkdir -p $(INSTALL_PATH)
	$(CMD_PREFIX)cp $(BINARY_PATH)/$(BINARY_NAME) $(INSTALL_PATH)/

$(LIBRARY_PATH)/lib$(LIBRARY_NAME).a:
	$(CMD_PREFIX)cd $(LIBRARY_SRC_PATH) ;  (test -f "Makefile" && $(MAKE) $(BUILD_TYPE) --no-print-directory) || true

$(BUILD_PATH)/%.o: $(SOURCE_PATH)/%.$(SOURCE_EXTENSION)
	@echo "Compiling: $< -> $@"
	$(CMD_PREFIX)$(CC) $(CFLAGS) $(INCLUDES) -MP -MMD -c $< -o $@

$(BINARY_PATH)/$(BINARY_NAME): $(LIBRARY_PATH)/lib$(LIBRARY_NAME).a $(OBJECTS)
	@echo "Linking: $@"
	$(CMD_PREFIX)$(CC) $(OBJECTS) $(LIBRARY_PATH)/lib$(LIBRARY_NAME).a $(LDFLAGS) -o $@

all: dirs $(BINARY_PATH)/$(BINARY_NAME)
	@echo "Making symlink: $(BINARY_NAME) -> $<"
	@$(RM) $(BINARY_NAME)
	@ln -s $(BINARY_PATH)/$(BINARY_NAME) $(BINARY_NAME)
