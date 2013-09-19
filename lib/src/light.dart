part of orange;

/// from J3D
class Light extends Transform{
  
  /// Type of light: None. This is used of shader internals.
  static final int NONE = -1;
  /// Type of light: Ambient. Only other setting used by ambient color.
  static final int AMBIENT = 0;
  /// Type of light: Directional. To determine its direction the transforms rotation is used. Other settings used by ths light are: color and intensity.
  static final int DIRECT = 1;
  /// Type of light: Point light. To determine its position the transforms position is used. Other settings used by ths light are: color and intensity.
  static final int POINT = 2;
  /// Type of light: Spotlight. To determine its position and direction the transforms position and rotation is used. Other settings used by ths light are: angle, angleFalloff, color and intensity.
  static final int SPOTLIGHT = 3;
  /// Type of light: Hemisphere light. Hemisphere light is similar to POint light, but the light calculation algorithm is slightly different. All the same parameters are used though.
  static final int HEMISPHERE = 4;
  /// Type of light: Spherical Harmonics. This light type does not have any settings. The coefficients are hardcoded into the shaders currently - (take a look at Lights.glsl) but there are plans to allow conditional compilation in shaders in the future. The one that is currently used is 'Grace Catherdral'.
  static final int SPHERICAL_HARMONICS = 5;
  
  Color color;
  double intensity;
  double angleFalloff;
  double angle;
  
  Vector3 ambientIntensity;
  Vector3 diffuseIntensity;
  Vector3 specularIntensity;
  
  int type;
  Light(num hex, [int type = -1]): color = new Color.fromHex(hex), this.type = type, super();
}

