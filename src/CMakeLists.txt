cmake_minimum_required (VERSION 2.6)

set(GLSL_SRCS 
GLSL.cpp
Imageloader.cpp
)

set(GLSL_HDRS
GLSL.h
Imageloader.h

)

add_library(GLSL ${GLSL_SRCS} ${GLSL_HDRS} )

add_executable(testGLSL		testGLSL.cpp)

if(UNIX)
target_link_libraries(testGLSL	GLSL pthread ${Boost_LIBRARIES} ${GL_LIBS} ${GLEW_LIBRARY} )
endif(UNIX)

if(WIN32)
target_link_libraries(testGLSL	GLViz GLSL ${Boost_LIBRARIES} ${GL_LIBS} ${GLEW_LIBRARY})
endif(WIN32)
