import 'dart:html';
import 'dart:math';
import '../lib/orange.dart';
import 'package:stats/stats.dart';
import 'dart:async';
//import 'package:vector_math/vector_math.dart';


double _lastElapsed = 0.0;
Renderer renderer;
Model model;
Animation animation;

void main() {
  var url = "http://127.0.0.1:3030/orange/testmodel/model/main_player_lorez";
  var canvas = querySelector("#container");
  renderer = new Renderer(canvas);
  
  model = new SkinnedModel();
  model.load(renderer.ctx, url);
  
  animation = new Animation();
  animation.load("http://127.0.0.1:3030/orange/testmodel/model/run_forward").then((_) {
    var frameId = 0;
    var frameTime = 1000 ~/ animation.frameRate;
    new Timer.periodic(new Duration(milliseconds: frameTime), (t) {
      if(model.complete) {
        animation.evaluate(frameId % animation.frameCount, model);
        frameId++;
      }
    });
  });
  
  window.requestAnimationFrame(_animate);
  window.onResize.listen((e){
    renderer.resize();
  });
}

_animate(num elapsed) {
  window.requestAnimationFrame(_animate);
  var interval = elapsed - _lastElapsed;
  
  renderer.camera.update(interval);
  renderer.drawFrame(model);

  _lastElapsed = elapsed;
}


















