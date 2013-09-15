library orange;


import 'dart:html' as html;
import 'dart:json' as json;
import 'dart:web_gl' as gl;
import 'dart:math' as math;
import 'dart:typed_data';
import 'package:vector_math/vector_math.dart';


part 'src/director.dart';
part 'src/transform.dart';
part 'src/camera.dart';
part 'src/mesh.dart';
part 'src/geometry.dart';
part 'src/material.dart';
part 'src/renderer.dart';
part 'src/shader.dart';
part 'src/scene.dart';
part 'src/primitives.dart';
part 'src/parser.dart';

part 'src/event/eventdispatcher.dart';
part 'src/event/events.dart';
part 'src/event/eventsubscription.dart';



Director _director;

initOrange(html.CanvasElement canvas) {
  _director = new Director._internal(canvas);
}

Director get director {
  return _director;
}