varying vec3 Normal;
varying vec3 EyeDir;
varying vec3 lightDirection;

uniform samplerCube cubeMap;
uniform gl_LightSourceParameters gl_LightSource[gl_MaxLights];

void main()
{
        gl_Position = gl_ModelViewProjectionMatrix*gl_Vertex;
        Normal = gl_NormalMatrix * gl_Normal;
        EyeDir = vec3(gl_ModelViewMatrix * gl_Vertex);

        vec3 vPosition3 =  vec3(gl_ModelViewProjectionMatrix*gl_Vertex);

        lightDirection = normalize( vec3(vec4( gl_LightSource[0].position.xyz, 1.0)) - EyeDir );
}
