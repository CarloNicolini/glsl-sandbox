varying vec2 texture_coordinate;

void main()
{
    // Passing The Texture Coordinate Of Texture Unit 0 To The Fragment Shader
    vec4 u = gl_ModelViewMatrix*gl_ProjectionMatrix*gl_Vertex;
    // If you want to take in account also world transformation, you have to

    // u represents the Normalized device coordinates of the vertices
    // Here you can use some different mapping
    texture_coordinate = vec2( 0.5*(1+(u.x) ), gl_Vertex.z  );

    gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
}
