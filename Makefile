# --- iTF Surgical Makefile ---

PROJECT_NAME = iTF
BUILD_DIR = build
SRC_DIR = src
SDK_PATH = $(shell xcrun --sdk iphoneos --show-sdk-path)
TARGET = arm64-apple-ios15.0

# Compilers
SWIFTC = swiftc
CLANG = clang++

# Flags
SWIFT_FLAGS = -sdk $(SDK_PATH) -target $(TARGET) -import-objc-header src/utils/Bridge.h -I include
CPP_FLAGS = -isysroot $(SDK_PATH) -target $(TARGET) -std=c++17 -I include

# Sources
SWIFT_SRCS = $(SRC_DIR)/main.swift $(SRC_DIR)/ui/TerminalView.swift
CPP_SRCS = $(SRC_DIR)/shell/Shell.cpp $(SRC_DIR)/shell/ShellWrapper.cpp
OBJS = $(BUILD_DIR)/Shell.o $(BUILD_DIR)/ShellWrapper.o

.PHONY: all clean ipa

all: $(BUILD_DIR)/$(PROJECT_NAME)

# 1. Compile C++ logic to object files
$(BUILD_DIR)/%.o: $(SRC_DIR)/shell/%.cpp
	@mkdir -p $(BUILD_DIR)
	$(CLANG) $(CPP_FLAGS) -c $< -o $@

# 2. Compile Swift and link with C++ objects
$(BUILD_DIR)/$(PROJECT_NAME): $(OBJS)
	$(SWIFTC) $(SWIFT_FLAGS) $(SWIFT_SRCS) $(OBJS) -o $@

# 3. Package into .ipa (for GitHub Actions / Sideloading)
ipa: all
	@mkdir -p $(BUILD_DIR)/Payload/$(PROJECT_NAME).app
	cp $(BUILD_DIR)/$(PROJECT_NAME) $(BUILD_DIR)/Payload/$(PROJECT_NAME).app/
	cp resources/Info.plist $(BUILD_DIR)/Payload/$(PROJECT_NAME).app/
	cd $(BUILD_DIR) && zip -r ../$(PROJECT_NAME).ipa Payload/
	@echo "Surgical IPA built at ./$(PROJECT_NAME).ipa"

clean:
	rm -rf $(BUILD_DIR) *.ipa