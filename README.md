glsl-sandbox
============

glsl-sandbox is a repo for glsl shaders experiments

Here I'm collecting all the shaders I wrote and collected over the months in order to share them with others.

How to build on Linux
====

If you want to build the simple exampe testGLSL.cpp you have to install

1) CMake > 2.6 ( www.cmake.org )

2) GLEW (you can download at http://glew.sourceforge.net/ or install it with `sudo apt-get install glew-utils`)

3) gcc/g++ and gnumake ( you can install them with `sudo apt-get install build-essential` )

and obviously OpenGL and GLUT.

First clone the repository:

    git clone 

Enter the directory:

    cd glsl-sandbox

and then issue:

    cmake .

this will generate the correct Makefiles. You simply have to give a `make` command to build the executables.

You can try different shaders passing them as the first parameter of the executable:
(you have to give the name without the `.vert` or `.frag` extensions, vertex shader and fragment shader are meant to have the same name, and the texture images are meant to be in `.bmp` format )
For example:

    ./build/testGLSL shaders/ADS myimage.bmp