varying vec2 texture_coordinate;
float twopi = 6.283185307;
float pi=3.141592654;
float halfpi=1.570796327;
float invpi = 0.318309886;

varying float radiusX ;
varying float radiusY ;

uniform float time;

void main()
{
    radiusX=1.0;
    radiusY=1.0;
    // Transforming The Vertex
    gl_Vertex.x*=radiusX;
    gl_Vertex.y*=radiusY;

    // -pi/2 < theta < pi/2
    float z = gl_Vertex.y;//sqrt(1.0-gl_Vertex.x*gl_Vertex.x/(radiusX*radiusX));
    float theta = atan2( radiusY*z , gl_Vertex.x );
    float texX= (theta+pi/2.0)/(pi);

    // Passing The Texture Coordinate Of Texture Unit 0 To The Fragment Shader
    vec4 u = gl_ModelViewMatrix*gl_ProjectionMatrix*gl_Vertex;

    if ( sin(time) < 0 )
        texture_coordinate = vec2( 0.5*(1+(u.x)), gl_Vertex.z );
    // Standard traditional way to texturing
    else
        texture_coordinate = vec2( theta, gl_Vertex.z );

    //texture_coordinate = gl_MultiTexCoord0;
    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}


