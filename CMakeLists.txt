# Set the minimum version of CMake that can be used
cmake_minimum_required(VERSION 3.5)

# Set the name of project -> sets PROJECT_NAME
project(Emagick)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Add the source files of the project
set(SOURCES
    src/main.cpp
    src/utilities.cpp
    src/Emagick.cpp
    src/mainWindow.cpp
)

# Add the header files of the project
set(HEADERS
    include/Emagick.h
    include/utilities.h
    include/mainWindow.h
)

# Add the QML resource file
set(QML_RESOURCE src/qml.qrc)

# Find the packages
find_package(ImageMagick COMPONENTS Magick++ REQUIRED)
find_package(Qt6 REQUIRED COMPONENTS Core Gui Qml Quick Widgets)

# Add extra compiler flags
add_definitions(-DMAGICKCORE_HDRI_ENABLE=1 -DMAGICKCORE_QUANTUM_DEPTH=16)

# Generate executable in /bin
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

# For QML
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC OFF)

# Add the executable from sources
add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS} ${QML_RESOURCE})

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
    Qt6::Gui
    Qt6::Qml
    Qt6::Quick
    Qt6::Widgets
)
