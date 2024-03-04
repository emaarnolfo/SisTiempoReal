# Directories
BIN_DIR := bin
BUILD_DIR := build

# Compiler options
ADA_COMPILER := gnatmake
ADA_FLAGS := -gnat2012

# Source files
SOURCES := fracciones.ads fracciones.adb prueba.adb

# Output file
EXECUTABLE := $(BIN_DIR)/prueba

all: $(EXECUTABLE)

$(EXECUTABLE): $(SOURCES)
	@mkdir -p $(BIN_DIR)
	@mkdir -p $(BUILD_DIR)
	$(ADA_COMPILER) $(ADA_FLAGS) -o $@ $^ -b $(BUILD_DIR)

clean:
	rm -rf $(BIN_DIR) $(BUILD_DIR)
