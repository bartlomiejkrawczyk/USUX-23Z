BINARY_NAME := prog
CC ?= gcc
SOURCE_EXTENSION = c
SOURCE_PATH = .
LIBRARIES = m
COMPILE_FLAGS = -std=c99 -Wall -Wextra -Werror -pedantic -Wstrict-aliasing -Wunreachable-code -g
COMPLEX_COMPILE_FLAGS = -DZESPOLONE
REAL_COMPILE_FLAGS = -UZESPOLONE
INCLUDES = -I $(SOURCE_PATH) -I include
LINK_FLAGS =
COMPLEX_LINK_FLAGS =
REAL_LINK_FLAGS =

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
complex: export BINARY_PATH := bin/complex
real: export BUILD_PATH := build/real
real: export BINARY_PATH := bin/real

SOURCES = $(shell find $(SOURCE_PATH) -name '*.$(SOURCE_EXTENSION)')

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
	@mkdir -p $(BINARY_PATH)

.PHONY: clean
clean:
	@echo "Deleting $(BINARY_NAME) symlink"
	@$(RM) $(BINARY_NAME)
	@echo "Deleting build and bin directories"
	@$(RM) -r build
	@$(RM) -r bin

$(BUILD_PATH)/%.o: $(SOURCE_PATH)/%.$(SOURCE_EXTENSION)
	@echo "Compiling: $< -> $@"
	$(CMD_PREFIX)$(CC) $(CFLAGS) $(INCLUDES) -MP -MMD -c $< -o $@

$(BINARY_PATH)/$(BINARY_NAME): $(OBJECTS)
	@echo "Linking: $@"
	$(CMD_PREFIX)$(CC) $(OBJECTS) $(LDFLAGS) -o $@

all: $(BINARY_PATH)/$(BINARY_NAME)
	@echo "Making symlink: $(BINARY_NAME) -> $<"
	@$(RM) $(BINARY_NAME)
	@ln -s $(BINARY_PATH)/$(BINARY_NAME) $(BINARY_NAME)
