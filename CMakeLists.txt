cmake_minimum_required(VERSION 3.5)

# Set the name of project -> sets PROJECT_NAME
project(Emagick)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Add the source files of the project
set(SOURCES
    src/main.cpp
    src/utility.cpp
    src/Emagick.cpp
    src/guiHandler.cpp

    src/qml.qrc
)

# Add the header files of the project
set(HEADERS
    include/Emagick.h
    include/utility.h
    include/guiHandler.h
)

# Find the packages
find_package(ImageMagick COMPONENTS Magick++ REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS Core Qml Quick Widgets Gui)

# Add extra compiler flags
add_definitions(-DMAGICKCORE_HDRI_ENABLE=1 -DMAGICKCORE_QUANTUM_DEPTH=16)

# Generate executable in bin/
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

# For QML
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC OFF)

# Add the executable from sources
add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS})

# Set the directories that should be included in the build command for this target
target_include_directories(${PROJECT_NAME}
    PRIVATE
        ${ImageMagick_INCLUDE_DIRS}
        ${CMAKE_SOURCE_DIR}/include
)

# Link libraries
target_link_libraries(${PROJECT_NAME}
    ${ImageMagick_LIBRARIES}
    Qt6::Core
    Qt6::Qml
    Qt6::Quick
    Qt6::Widgets
    Qt6::Gui
)
