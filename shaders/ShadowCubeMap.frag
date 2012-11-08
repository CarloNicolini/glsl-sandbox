varying vec3 Normal;
varying vec3 EyeDir;

uniform samplerCube cubeMap;

uniform gl_LightSourceParameters gl_LightSource[gl_MaxLights];
varying vec3 lightDirection;

void main(void)
{
    vec3 reflectedDirection = normalize(reflect(EyeDir, normalize(Normal)));
    reflectedDirection.y = -reflectedDirection.y;

    vec4 ambientLight = gl_LightSource[0].ambient;
    vec4 diffuseLight = gl_LightSource[0].diffuse;
    vec4 specularLight = gl_LightSource[0].specular;

    vec3 lightDir = normalize(lightDirection.xyz);

    float diffusionIntensity = max(0.0,dot(normalize(Normal),normalize(lightDirection.xyz)));

    vec4 fragColor = diffusionIntensity+textureCube(cubeMap, reflectedDirection);
    gl_FragColor = fragColor;//fragColor;
}
