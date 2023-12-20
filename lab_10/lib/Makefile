LIBRARY_NAME ?= usux
BUILD_PATH ?= build
LIBRARY_PATH ?= lib

CC ?= gcc
SOURCE_EXTENSION = c
SOURCE_PATH = .
LIBRARIES = m
INCLUDES =../headers

COMPILE_FLAGS ?= -std=c99 -Wall -Wextra -Werror -pedantic -Wstrict-aliasing -Wunreachable-code -g
LINK_FLAGS ?=

print-%: ; @echo $*=$($*)

LINK_FLAGS += $(foreach LIBRARY,$(LIBRARIES),-l$(LIBRARY))

CMD_PREFIX := @
ifeq ($(VERBOSE),true)
	CMD_PREFIX :=
endif

.PHONY: build
build: echo_build all

CFLAGS := $(CFLAGS) $(COMPILE_FLAGS)
LDFLAGS := $(LDFLAGS) $(LINK_FLAGS)

SOURCES = $(shell find $(SOURCE_PATH) -name '*.$(SOURCE_EXTENSION)')

OBJECTS = $(SOURCES:$(SOURCE_PATH)/%.$(SOURCE_EXTENSION)=$(BUILD_PATH)/%.o)
DEPENDENCIES = $(OBJECTS:.o=.d)

-include $(DEPENDENCIES)

.PHONY: echo_build
echo_build:
	@echo "Start build"

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
	$(CMD_PREFIX)$(CC) $(CFLAGS) -I $(INCLUDES) -MP -MMD -c $< -o $@

$(LIBRARY_PATH)/lib$(LIBRARY_NAME).a: $(OBJECTS)
	@echo "Making library: $(LIBRARY_PATH)/lib$(LIBRARY_NAME).a from: $^"
	$(CMD_PREFIX)$(AR) -rv $(LIBRARY_PATH)/lib$(LIBRARY_NAME).a $? 2>/dev/null

all: dirs $(LIBRARY_PATH)/lib$(LIBRARY_NAME).a
