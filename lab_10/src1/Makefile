BINARY_NAME := prog_1
LIBRARY_NAME := usux
INSTALL_PATH ?= install
BUILD_PATH ?= build
BINARY_PATH ?= bin
LIBRARY_SRC_PATH ?= ../lib
LIBRARY_PATH ?= $(LIBRARY_SRC_PATH)/lib

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

CFLAGS ?= $(COMPILE_FLAGS) $(COMPLEX_COMPILE_FLAGS)
LDFLAGS ?= $(LINK_FLAGS) $(COMPLEX_LINK_FLAGS)

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
	@mkdir -p $(BINARY_PATH)

.PHONY: clean
clean:
	@echo "Deleting $(BINARY_NAME) symlink"
	$(CMD_PREFIX)$(RM) $(BINARY_NAME)
	@echo "Deleting build and bin directories"
	$(CMD_PREFIX)$(RM) -r $(BUILD_PATH)
	$(CMD_PREFIX)$(RM) -r $(BINARY_PATH)
	$(CMD_PREFIX)$(RM) -r $(INSTALL_PATH)

.PHONY: install
install: all
	@echo "Installing $(BINARY_NAME)"
	@mkdir -p $(INSTALL_PATH)
	$(CMD_PREFIX)cp $(BINARY_PATH)/$(BINARY_NAME) $(INSTALL_PATH)/

$(LIBRARY_PATH)/lib$(LIBRARY_NAME).a:
	$(CMD_PREFIX)cd $(LIBRARY_SRC_PATH) ;  (test -f "Makefile" && $(MAKE) --no-print-directory) || true

$(BUILD_PATH)/%.o: $(SOURCE_PATH)/%.$(SOURCE_EXTENSION)
	@echo "Compiling: $< -> $@"
	$(CMD_PREFIX)$(CC) $(CFLAGS) -I $(INCLUDES) -MP -MMD -c $< -o $@

$(BINARY_PATH)/$(BINARY_NAME): $(LIBRARY_PATH)/lib$(LIBRARY_NAME).a $(OBJECTS)
	@echo "Linking: $@"
	$(CMD_PREFIX)$(CC) $(OBJECTS) $(LIBRARY_PATH)/lib$(LIBRARY_NAME).a $(LDFLAGS) -o $@

all: dirs $(BINARY_PATH)/$(BINARY_NAME)
	@echo "Making symlink: $(BINARY_NAME) -> $(BINARY_PATH)/$(BINARY_NAME)"
	@$(RM) $(BINARY_NAME)
	@ln -s $(BINARY_PATH)/$(BINARY_NAME) $(BINARY_NAME)
