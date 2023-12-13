CC ?= gcc
SOURCE_EXTENSION = c
SOURCE_PATH = .
LIBRARIES =
COMPILE_FLAGS = -std=c99 -Wall -Wextra -Werror -pedantic -Wstrict-aliasing -Wunreachable-code -g
INCLUDES = -I $(SOURCE_PATH) -I headers
LINK_FLAGS =

print-%: ; @echo $*=$($*)

LINK_FLAGS += $(foreach LIBRARY,$(LIBRARIES),-l$(LIBRARY))

CMD_PREFIX := @
ifeq ($(VERBOSE),true)
	CMD_PREFIX :=
endif

BINARY_NAME := prog # TODO: this must be the name of file containing main

CFLAGS := $(CFLAGS) $(COMPILE_FLAGS)
LDFLAGS := $(LDFLAGS) $(LINK_FLAGS)

BUILD_PATH := build
BINARY_PATH := bin

SOURCES = $(shell find $(SOURCE_PATH) -name '*.$(SOURCE_EXTENSION)')

OBJECTS = $(SOURCES:$(SOURCE_PATH)/%.$(SOURCE_EXTENSION)=$(BUILD_PATH)/%.o)
DEPENDENCIES = $(OBJECTS:.o=.d)

-include $(DEPENDENCIES)

.PHONY: build
build: all

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

all: dirs $(BINARY_PATH)/$(BINARY_NAME)
	@echo "Making symlink: $(BINARY_NAME) -> $<"
	@$(RM) $(BINARY_NAME)
	@ln -s $(BINARY_PATH)/$(BINARY_NAME) $(BINARY_NAME)
