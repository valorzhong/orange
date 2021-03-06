part of orange_examples;





class TestTexturesScene extends Scene {

  TestTexturesScene(Camera camera) : super(camera);

  @override
  void enter() {

    camera.setTranslation(0.0, 2.0, 4.0);
    camera.lookAt(new Vector3.zero());

    var skybox = new Cube(width: 1000, height: 1000, depth: 1000);
    skybox.material = new StandardMaterial();
    skybox.material.backFaceCulling = false;
    skybox.material.reflectionTexture = new CubeTexture("textures/cube/Bridge2/bridge");
    skybox.material.reflectionTexture.coordinatesMode = Texture.SKYBOX_MODE;
    skybox.material.diffuseColor = new Color.fromList([0.0, 0.0, 0.0]);
    skybox.material.specularColor = new Color.fromList([0.0, 0.0, 0.0]);
    add(skybox);

    var sphere = new SphereMesh();
    sphere.rotateY(PI/5);
    sphere.material = new StandardMaterial();
    sphere.material.diffuseColor = new Color(0, 255, 0);
    sphere.material.specularColor = new Color(255, 255, 255);
    sphere.material.emissiveColor = new Color(255, 0, 0);

    sphere.material.reflectionTexture = Texture.load(graphicsDevice.ctx, {
      "path": "textures/reflectiontexture.jpg"
    });
    sphere.material.reflectionTexture.coordinatesMode = Texture.SPHERICAL_MODE;

    sphere.material.emissiveTexture = Texture.load(graphicsDevice.ctx, {
      "path": "textures/leaf_textures.jpg"
    });

    sphere.material.diffuseTexture = Texture.load(graphicsDevice.ctx, {
      "path": "textures/tree.png"
    });

    sphere.material.opacityTexture = Texture.load(graphicsDevice.ctx, {
      "path": "textures/ani2.jpg"
    });
    sphere.material.opacityTexture.getAlphaFromRGB = true;

    sphere.material.bumpTexture = Texture.load(graphicsDevice.ctx, {
      "path": "textures/bump.png"
    });

    add(sphere);

    var group = new PlaneMesh(width: 3, height: 3, ground: true);
    group.translate(0.0, -1.0);
    group.material = new StandardMaterial();
    group.material.reflectionTexture = new MirrorTexture(graphicsDevice, 512, 512);
    add(group);

    var pointLight0 = new PointLight(0xffffff);
    pointLight0.translate(new Vector3(-5.0, 3.0, 0.0));
    add(pointLight0);
  }

  @override
  void exit() {
    removeChildren();
  }
}
