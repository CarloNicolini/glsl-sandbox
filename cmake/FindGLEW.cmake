# Taken from www.openlibraries.org/browser/trunk/FindGLEW.cmake - LGPL?
# Taken on 1 December 2008, works well on Linux at least, Marcus.
#
# - Try to find GLEW
# Once done this will define
# 
#  GLEW_FOUND        - system has GLEW
#  GLEW_INCLUDE_DIR  - the GLEW include directory
#  GLEW_LIBRARY_DIR  - where the libraries are
#  GLEW_LIBRARY      - Link these to use GLEW
#   

IF (GLEW_INCLUDE_DIR)
  SET(GLEW_FIND_QUIETLY TRUE)
ENDIF (GLEW_INCLUDE_DIR)

if( WIN32 )
   set( GLEW_INCLUDE_DIR  "${CMAKE_CURRENT_SOURCE_DIR}/deps/glew-1.7.0" )
   include_directories(${GLEW_INCLUDE_DIR})
   include_directories(${GLEW_INCLUDE_DIR}/include)
       find_path( GLEW_INCLUDE_DIR
                   NAMES GL/glew.h GL/wglew.h
                   PATHS deps/glew-1.7.0/
                   NO_DEFAULT_PATH NO_CMAKE_ENVIRONMENT_PATH
                   NO_CMAKE_PATH NO_SYSTEM_ENVIRONMENT_PATH
                   NO_CMAKE_SYSTEM_PATH 
                   )
				   
	SET( GLEW_NAMES glew32 )
	find_library( GLEW_LIBRARY
                      NAMES ${GLEW_NAMES}
                      PATHS deps/glew-1.7.0/lib/
                      NO_DEFAULT_PATH NO_CMAKE_ENVIRONMENT_PATH
                      NO_CMAKE_PATH NO_SYSTEM_ENVIRONMENT_PATH
                      NO_CMAKE_SYSTEM_PATH
                      )
else( WIN32 )
   FIND_PATH( GLEW_INCLUDE_DIR glew.h wglew.h
              NAMES gl/glew.h GL/glew.h
              PATHS /usr/local/include /opt/local/include /usr/include
            )
   SET( GLEW_NAMES glew GLEW )
   FIND_LIBRARY( GLEW_LIBRARY
              NAMES ${GLEW_NAMES}
              PATHS /usr/lib /usr/local/lib /opt/local/lib )
endif( WIN32 )

GET_FILENAME_COMPONENT( GLEW_LIBRARY_DIR ${GLEW_LIBRARY} PATH )

IF (GLEW_INCLUDE_DIR AND GLEW_LIBRARY)
   SET(GLEW_FOUND TRUE)
ELSE (GLEW_INCLUDE_DIR AND GLEW_LIBRARY)
   SET( GLEW_FOUND FALSE )
   SET( GLEW_LIBRARY_DIR )
ENDIF (GLEW_INCLUDE_DIR AND GLEW_LIBRARY)