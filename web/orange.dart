import 'dart:html' as html;
import 'package:orange/orange.dart';
import 'package:stats/stats.dart';
import 'show_boundingbox.dart';
import 'test_physics.dart';
import 'test_animation.dart';
import 'test_renderer.dart';
import 'test_gltf.dart';




void main() {
  var canvas = html.querySelector("#container");
  var renderer = new GraphicsDevice(canvas);
  var camera = new PerspectiveCamera(canvas.width / canvas.height);
  camera.position.setValues(0.0, 0.0, 4.0);
  var controls = new OrbitControls();
  controls.attach(camera, canvas);

  var stats = new Stats();
  html.document.body.children.add(stats.container);

  var director = new Director(renderer);
  
  var scenes = [new TestAnimationScene(camera), 
                new ShowBoundingBoxScene(camera), 
                new TestLightingScene(camera), 
                new PhysicsScene(camera),
                new TestGLTFScene(camera)];
  var i = 4;
  
  director.replace(scenes[i]);
  director.run();
  director.afterRenders.add(() {
    stats.end();
    stats.begin();
  });

  var controllers = html.querySelector("#controllers");
  var selector = html.querySelector("#scenes") as html.SelectElement;
  selector.selectedIndex = i;
  selector.onChange.listen((e) {
    controllers.children.clear();
    director.replace(scenes[int.parse(selector.value)]);
  });

}










