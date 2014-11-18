/*
  Orange : Simplified BSD License

  Copyright (c) 2014, Valor Zhong
  All rights reserved.
  
  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the 
  following conditions are met:
  
  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following 
     disclaimer.
    
  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the 
     following disclaimer in the documentation and/or other materials provided with the distribution.
  
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
  INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR 
  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  
 */

part of orange;



class Pass {
  Effect effect;
  RenderState renderState;

  bool bind(GraphicsDevice device, RenderData context) {
    effect.compile(context);

    if (!effect.ready) return false;

    device.useEffect(effect);
    device.setRenderState(renderState);

    for (var i = 0; i < effect.samplers.length; i++) {
      var parameter = effect.uniforms[effect.samplers[i]];
      device.setInt(parameter.location, i);
    }

    // set uniforms
    effect.uniforms.forEach((String name, EffectParameter parameter) {
      parameter.bind(device, context);
    });

    // set attributes
    effect.attributes.forEach((String name, EffectParameter parameter) {
      parameter.bind(device, context);
    });

    return true;
  }

  void unbind(GraphicsDevice device) {
    effect.attributes.forEach((String name, EffectParameter parameter) {
      device.disableVertexAttribute(parameter.location);
    });
  }
}
