project(glsl-sandbox)
CMAKE_MINIMUM_REQUIRED(VERSION 2.6.0 FATAL_ERROR)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
set(PROJECT_BINARY_DIR "${CMAKE_CURRENT_SOURCE_DIR}/build/")
set(LIBRARY_OUTPUT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/build/" CACHE PATH "Single directory for all libraries")
set(EXECUTABLE_OUTPUT_PATH "${CMAKE_CURRENT_SOURCE_DIR}/build/" CACHE PATH "Single directory for all executables")

####################### USER OPTIONS  ##################################
if (WIN32)
option(EYEGAZE_SUPPORT "Include and link EyeGaze libraries (only for Windows)" ON)
endif(WIN32)
if (WIN32 AND EYEGAZE_SUPPORT)
find_package(Eyegaze)
endif (WIN32 AND EYEGAZE_SUPPORT)

option(QT_SUPPORT "Compile and link the Qt related examples and libraries")

####################### FIND PACKAGES AND LIBRARIES ####################
find_package(StandardMathLibrary)
find_package(FFTW)

set(BOOST_LIBS thread date_time system program_options filesystem regex serialization iostreams)

set(Boost_USE_STATIC_LIBS        ON)
set(Boost_USE_MULTITHREADED      ON)
set(Boost_USE_STATIC_RUNTIME    OFF)

link_directories ( ${Boost_LIBRARY_DIRS} )
include_directories ( ${Boost_INCLUDE_DIRS} )
find_package(Boost COMPONENTS ${BOOST_LIBS} REQUIRED)
include_directories(${Boost_INCLUDE_DIR})
find_package(Threads REQUIRED)
####################### END BOOST LIBRARIES INCLUDE AND LINKING ################

if(WIN32)
set( COMPILE_OPTOTRAK TRUE)
set(OPTOTRAK_LIBRARIES ${CMAKE_SOURCE_DIR}/deps/drivers/NDIoapi/Win32/ndlib/msvc/oapi.lib)
include_directories(${CMAKE_SOURCE_DIR}/deps/drivers/NDIoapi/Win32/ndlib/include)
else(WIN32)
set( COMPILE_OPTOTRAK FALSE)
#set(OPTOTRAK_LIBRARIES ${CMAKE_SOURCE_DIR}/deps/drivers/NDIoapi/Win32/ndlib/msvc/oapi.lib)
include_directories(${CMAKE_SOURCE_DIR}/deps/drivers/NDIoapi/Linux/ndlib/include/)
endif(WIN32)


##########  CROSS-PLATFORM OPENGL + GLUT ########################
IF(APPLE)
	# PARAMETRO IMPORTANTE PER FARE LA BUILD SU OSX CON LIBRERIE 64 bit, potrebbe non essere necessario su altri mac!!!
	include_directories ( /System/Library/Frameworks )
	find_package(OpenGL REQUIRED)
	find_package(GLUT REQUIRED)
	include_directories(${OPENGL_INCLUDE_DIR})
	find_library(OpenGL_LIBRARY OpenGL )
	find_library(GLUT_LIBRARY GLUT )
	# Linkare le librerie opengl e glut
	set(GL_LIBS "-framework GLUT -framework OpenGL" )
ENDIF (APPLE)

IF ( UNIX AND NOT APPLE)
	find_package(OpenGL REQUIRED)
	include_directories(${OPENGL_INCLUDE_DIR})
	find_package(GLUT REQUIRED)
	set(GL_LIBS ${OPENGL_LIBRARIES} ${GLUT_LIBRARIES})
ENDIF ( UNIX AND NOT APPLE)

IF (WIN32 )
	set(GLUT_INCLUDE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/deps/glutwin32")
	include_directories(${GLUT_INCLUDE_DIR})
   # Find supplied library
        find_path( GLUT_INCLUDE_DIR
                   NAMES GL/glut.h
                   PATHS deps/glutwin32
                   NO_DEFAULT_PATH NO_CMAKE_ENVIRONMENT_PATH
                   NO_CMAKE_PATH NO_SYSTEM_ENVIRONMENT_PATH
                   NO_CMAKE_SYSTEM_PATH
                   )
        find_library( GLUT_glut_LIBRARY
                      NAMES glut glut32 
                      PATHS deps/glutwin32
                      NO_DEFAULT_PATH NO_CMAKE_ENVIRONMENT_PATH
                      NO_CMAKE_PATH NO_SYSTEM_ENVIRONMENT_PATH
                      NO_CMAKE_SYSTEM_PATH
                      )
        mark_as_advanced( GLUT_INCLUDE_DIR GLUT_glut_LIBRARY )
        if( GLUT_INCLUDE_DIR AND GLUT_glut_LIBRARY )
          set( GLUT_FOUND 1 )
        endif( GLUT_INCLUDE_DIR AND GLUT_glut_LIBRARY )
   find_package(OpenGL REQUIRED)
   find_package(GLUT REQUIRED)
   set(GL_LIBS ${OPENGL_LIBRARIES} ${GLUT_LIBRARIES})
ENDIF(WIN32)
################################## END OPENGL ##################################

############################ FIND OPENGL EXTENSIONS GLEW #######################
find_package (GLEW)
if (NOT GLEW_FOUND)
  message (FATAL_ERROR "GLEW not found!")
endif ()

##########################  IF GNU COMPILER ####################################
if(CMAKE_COMPILER_IS_GNUCXX)
	if (COMPILE_OPTOTRAK)	# THESE FLAGS ARE NEEDED FOR COMPATIBILITY WITH NDI OAPI LIBRARIES
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -fpermissive")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -fpermissive -ldl -ggdb -O0")
	endif(COMPILE_OPTOTRAK)
endif(CMAKE_COMPILER_IS_GNUCXX)

########################## ENDIF GNU COMPILER ##################################

########################## IF MICROSOFT COMPILER ###############################
# Push more optimization options with Microsoft Compiler
if(MSVC)
# This set the following defines when compiling on windows
# _WIN32, _NOMINMAX, disable some stupid warnings and enable multiprocessor compilation (/MP)
add_definitions("-D_WIN32 -DNOMINMAX /EHsc /wd4127 /wd4129 /wd4505 /wd4714 /wd4800 /wd4181 /wd4244 /wd4996 /MP -D_WIN32_WINNT=0x0501")
# This push some other optimizations in order: Full optimization (Ox), omit frame pointer (Oy), Enable FiberSafe optimizations(GT),
# Whole Program Optimization (/GL), OpenMP support (/openmp), NONdynamic runtime libraries (MT)
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /arch:SSE2 /Ox /Oy /GT /GL")
# Specify to use multithreaded debug (non dynamic)
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}")
endif(MSVC)
####################### END IF MICROSOFT COMPILER #############################

# Activates OpenMP on architectures which support it
#include(FindOpenMP)
#if(OPENMP_FOUND)
#	message(STATUS "Adding OpenMP flags to MSVC: ${OpenMP_CXX_FLAGS} and ${OpenMP_EXE_LINKER_FLAGS}")
#    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
#    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")
#endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_BINARY_DIR} ${PROJECT_BINARY_DIR} )

add_subdirectory(src)

set(COMPILE_EXPERIMENTS TRUE)
if ( COMPILE_EXPERIMENTS )
add_subdirectory( experiments )
endif ( COMPILE_EXPERIMENTS )
