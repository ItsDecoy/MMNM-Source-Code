package;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxShader;

class CRTShader extends FlxShader
{
	@:glFragmentSource('
		#pragma header
        #ifdef GL_ES
            precision highp float;
        #endif
        #define PI 3.1415926538

        const float scale = 1.0;

        uniform vec2 curvature;
        uniform float uTime;
        uniform vec2 resolution;
        uniform vec2 scanLineOpacity;
        uniform float brightness;
        uniform float vignetteOpacity;

        vec2 screenDistort(vec2 uv)
		{
            uv = uv * 2.0 - 1.0;
            vec2 offset = abs(uv.yx) / vec2(curvature.x, curvature.y);
            uv = uv + uv * offset * offset;
            uv = uv * 0.5 + 0.5;
            return uv;
		}

        vec4 scanLineIntensity(float uv, float resolution, float opacity)
        {
            float intensity = sin(uv * resolution * PI * 2.0);
            intensity = ((0.5 * intensity) + 0.5) * 0.9 + 0.1;
            return vec4(vec3(pow(intensity, opacity)), 1.0);
        }

        vec4 vignetteIntensity(vec2 uv, vec2 resolution, float opacity)
        {
            float intensity = uv.x * uv.y * (1.0 - uv.x) * (1.0 - uv.y);
            return vec4(vec3(clamp(pow((resolution.x / 4.0) * intensity, opacity), 0.0, 1.0)), 1.0);
        }
		
        void main() 
        {
            vec2 uv = openfl_TextureCoordv;
            vec2 nuv = screenDistort(uv);

            float hres = 600, vres = 480;

            vec2 cell, local;

            cell.x = floor(nuv.x * hres) / hres;
            cell.y = floor(nuv.y * vres) / vres;
            
            local.x = fract(nuv.x * hres);
            local.y = fract(nuv.y * vres);

            vec4 source = flixel_texture2D(bitmap, cell);

            source *= vignetteIntensity(nuv, resolution, vignetteOpacity);

            if (mod(floor(openfl_TextureCoordv.y * openfl_TextureSize.y / scale), 2.0) == 0.0)
            {
                vec3 color = mix(source.rgb, vec3(0.0,0.0,0.0), scanLineOpacity.y * source.a);
                source = vec4(color , source.a);
            }

            source *= vec4(vec3(brightness), 1.0);
				

            if (nuv.x < 0.0 || nuv.y < 0.0 || nuv.x > 1.0 || nuv.y > 1.0){
                source = vec4(0.0, 0.0, 0.0, 1.0);
            } 

            gl_FragColor = source;
        }

        
		')
	public function new()
	{
		super();
		curvature.value = [3, 3];
		resolution.value = [150, 75];
		scanLineOpacity.value = [0.25, 0.25];
		brightness.value = [1.5];
		vignetteOpacity.value = [0.3];
	}
}