// This file is part of glsl-sandbox

// Copyright (C) 2012 Carlo Nicolini <carlo.nicolini@iit.it>
//
//
// glsl-sandbox is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 3 of the License, or (at your option) any later version.
//
// Alternatively, you can redistribute it and/or
// modify it under the terms of the GNU General Public License as
// published by the Free Software Foundation; either version 2 of
// the License, or (at your option) any later version.
//
//  glsl-sandbox is distributed in the hope that it will be useful, but WITHOUT ANY
// WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License or the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License and a copy of the GNU General Public License along with
//  glsl-sandbox. If not, see <http://www.gnu.org/licenses/>.

/* File for "Putting It All Together" lesson of the OpenGL tutorial on
 * www.videotutorialsrock.com
 */



#ifndef _IMAGE_LOADER_H_INCLUDED_
#define _IMAGE_LOADER_H_INCLUDED_

#ifdef __APPLE__
#include <OpenGL/OpenGL.h>
#include <GLUT/glut.h>
#endif
#ifdef __linux__
#include <GL/gl.h>
#include <GL/glu.h>
#include <GL/glut.h>
#endif

#ifdef _WIN32
#include <windows.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include "glut.h"
#endif

/**
*
* \class Image
* \ingroup GLVisualization
* \brief Represents an image as loaded from a bitmap file. This class helps the user to load an external texture.
**/

class Image
{
public:
   Image(char* ps, int w, int h);
   ~Image();

   /* An array of the form (R1, G1, B1, R2, G2, B2, ...) indicating the
    * color of each pixel in image.  Color components range from 0 to 255.
    * The array starts the bottom-left pixel, then moves right to the end
    * of the row, then moves up to the next column, and so on.  This is the
    * format in which OpenGL likes images.
    */
   char* pixels;
   int width;
   int height;
};

//Reads a bitmap image from file.
Image* loadBMP(const char* filename);


#endif /*_IMAGE_LOADER_H_INCLUDED_ */

