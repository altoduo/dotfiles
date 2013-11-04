# folder locations
SRC_PATH := src
BUILD_PATH := build
OBJ_PATH := $(BUILD_PATH)/obj
DEP_PATH := $(BUILD_PATH)/deps

# compilers
CC := gcc
CXX := g++

# libraries

# cflags
CFLAGS := -Wall
CXXFLAGS := $(CFLAGS)
LDFLAGS := -lstdc++ $(OPENGL_LIB)

# files to compile
#C_SOURCES	:= $(wildcard $(SRC_PATH)/*.c)
CXX_SOURCES	:= $(wildcard $(SRC_PATH)/*.cpp)
DEP_FILES	:= $(patsubst $(SRC_PATH)/%.cpp, $(DEP_PATH)/%.d, $(CXX_SOURCES))
OBJ_FILES	:= $(patsubst $(SRC_PATH)/%.cpp, $(OBJ_PATH)/%.o, $(CXX_SOURCES))
BINARY		:= $(BUILD_PATH)/program

# global rule, depends on main binary
all: $(BINARY)
	
# rule to build main binary
$(BINARY): $(OBJ_FILES)
	@echo "Linking $(BINARY)"
	$(CXX) $(LDFLAGS) -o $(BINARY) $(OBJ_FILES)

# rule to build dependencies
$(DEP_PATH)/%.d: $(SRC_PATH)/%.cpp
	@mkdir -p $(DEP_PATH)
	echo -n "$(OBJ_PATH)/" > $@
	$(CXX) -MM $^ >> $@

# include the dependencies
-include $(DEP_FILES)

# general rule for object files
$(OBJ_PATH)/%.o: $(SRC_PATH)/%.cpp
	@mkdir -p $(OBJ_PATH)
	$(CXX) $(CXXFLAGS) -c $(patsubst $(OBJ_PATH)/%.o, $(SRC_PATH)/%.cpp, $@) -o $@
	
# delete the directories and put back in the structure
clean:
	rm -rf $(BUILD_PATH)
	rm -rf $(DEP_PATH)
	
test:
	@echo "cpp sources: $(CXX_SOURCES)"
	@echo "dep files: $(DEP_FILES)"
	@echo "obj files: $(OBJ_FILES)"
