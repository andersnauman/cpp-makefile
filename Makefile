INCLUDE = include

CC = g++
CFLAGS = -Wall -g --std=c++11 -I$(INCLUDE)
LINKER = g++
LFLAGS = -Wall -g --std=c++11 -I$(INCLUDE)

SRCDIR = src
OBJDIR = obj
BINDIR = bin

TARGET = $(MAKECMDGOALS)
ifeq ($(TARGET),cleanDebug)
	TARGET = Debug
else ifeq ($(TARGET),cleanRelease)
	TARGET = Release
endif

PROJECT = main
BINARY = $(BINDIR)/$(TARGET)/$(PROJECT)

SOURCES := $(shell find $(SRCDIR)/ -name '*.cpp')
OBJECTS := $(SOURCES:$(SRCDIR)/%.cpp=$(OBJDIR)/$(TARGET)/%.o)

Debug: $(BINARY)
cleanDebug: clean

Release: $(BINARY)
cleanRelease: clean

$(BINARY): $(OBJECTS)
	@mkdir -p $(@D)
	$(LINKER) $(LFLAGS) $(OBJECTS) -o $@
	@echo "Linking complete!"

$(OBJECTS): $(OBJDIR)/$(TARGET)/%.o : $(SRCDIR)/%.cpp
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) -c $< -o $@
	@echo "Compiled " $< " successfully!"

clean:
	rm -f $(OBJECTS) $(BINARY)
	@echo "Cleanup is complete!"
