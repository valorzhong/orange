part of orange;



class Shader {
  bool ready = false;
  
  gl.Program program;
  Map<String, ShaderProperty> attributes;
  Map<String, ShaderProperty> uniforms;
  
  Shader(gl.RenderingContext ctx, String vertexShaderSource, String fragmentShaderSource) {
    _initialize(ctx, vertexShaderSource, fragmentShaderSource);
  }
  
  Shader.load(gl.RenderingContext ctx, String vertexShaderUrl, String fragmentShaderUrl) {
    Future.wait([html.HttpRequest.getString(vertexShaderUrl), 
                 html.HttpRequest.getString(fragmentShaderUrl)])
                   .then((r) => _initialize(ctx, r[0], r[1]));
  }
  
  _initialize(gl.RenderingContext ctx, String vertexShaderSource, String fragmentShaderSource) {
    var vertexShader = _compileShader(ctx, vertexShaderSource, gl.VERTEX_SHADER);
    var fragmentShader = _compileShader(ctx, fragmentShaderSource, gl.FRAGMENT_SHADER);
    program = ctx.createProgram();
    ctx.attachShader(program, vertexShader);
    ctx.attachShader(program, fragmentShader);
    ctx.linkProgram(program);
    if(!ctx.getProgramParameter(program, gl.LINK_STATUS)) {
      ctx.deleteProgram(program);
      ctx.deleteShader(vertexShader);
      ctx.deleteShader(fragmentShader);
    } else {
      attributes = {};
      var attribCount = ctx.getProgramParameter(program, gl.ACTIVE_ATTRIBUTES);
      for(var i = 0; i < attribCount; i++) {
        var info = ctx.getActiveAttrib(program, i);
        attributes[info.name] = new ShaderProperty(info.name, ctx.getAttribLocation(program, info.name), info.type);
      }
      
      uniforms = {};
      var uniformCount = ctx.getProgramParameter(program, gl.ACTIVE_UNIFORMS);
      for(var i = 0; i < uniformCount; i++) {
        var uniform = ctx.getActiveUniform(program, i);
        var name = uniform.name;
        var ii = name.indexOf("[0]");
        if(ii != -1) {
          name = name.substring(0, ii);
        }
        uniforms[name] = new ShaderProperty(name, ctx.getUniformLocation(program, name), uniform.type);
      }
      ready = true;
    }
  }
  
  gl.Shader _compileShader(gl.RenderingContext ctx, String source, int type) {
    var shader = ctx.createShader(type);
    ctx.shaderSource(shader, source);
    ctx.compileShader(shader);
    var s = ctx.getShaderParameter(shader, gl.COMPILE_STATUS);
    if (ctx.getShaderParameter(shader, gl.COMPILE_STATUS) == false) {
      print(ctx.getShaderInfoLog(shader));
      ctx.deleteShader(shader);
      return null;
    }
    return shader;
  }
  
  uniform(gl.RenderingContext ctx, String symbol, value) {
    if(uniforms.containsKey(symbol) && value != null) {
      var property = uniforms[symbol];
      switch(property.type) {
        case gl.FLOAT_MAT2:
          ctx.uniformMatrix2fv(property.location, false, value); break;
        case gl.FLOAT_MAT3:
          ctx.uniformMatrix3fv(property.location, false, value.storage); break;
        case gl.FLOAT_MAT4:
          ctx.uniformMatrix4fv(property.location, false, value); break;
        case gl.FLOAT:
          ctx.uniform1f(property.location, value); break;
        case gl.FLOAT_VEC2:
          ctx.uniform2fv(property.location, value.storage); break;
        case gl.FLOAT_VEC3:
          ctx.uniform3fv(property.location, value); break;
        case gl.FLOAT_VEC4:
          ctx.uniform4fv(property.location, value.storage); break;
        case gl.INT:
          ctx.uniform1i(property.location, value); break;
        case gl.SAMPLER_2D:
          ctx.uniform1i(property.location, value); break;
        case gl.SAMPLER_CUBE:
          ctx.uniform1i(property.location, value); break;
      }
    }
  }
  
  
}

class ShaderProperty {
  String name;
  dynamic location;
  int type;
  ShaderProperty(this.name, this.location, this.type);
}