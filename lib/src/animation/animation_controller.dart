part of orange;



class AnimationController {
  String name;
  Animation _animation;
  Map<String, Animation> animations;
  Mesh _mesh;
  double _duration = 0.0;
  Matrix4 _tempMatrix = new Matrix4.zero();
  bool useBindPose = true;

  AnimationController(this._mesh) {
    _mesh.animator = this;
  }

  switchAnimation(String name) {
    _animation = animations[name];
  }

  evaluate(double interval) {
    if (_animation == null) return;
    var skeleton = _animation.skeleton;
    _duration += interval * 0.001;
    _duration = _duration % _animation.length;
    Keyframe startframe, endframe;
    _animation.tracks.forEach((track) {
      var joint = skeleton.find(track);
      if (joint == null) return;

      for (var i = 0; i < track.keyframes.length - 1; i++) {
        startframe = track.keyframes[i];
        endframe = track.keyframes[i + 1];
        if (endframe.time >= _duration) {
          break;
        }
      }
      var percent = (_duration - startframe.time) / (endframe.time - startframe.time);
      var pos = lerp(startframe.translate, endframe.translate, percent);
      var rot = slerp(startframe.rotate, endframe.rotate, percent);
      joint._needsUpdateLocalMatrix = false;
      if (useBindPose) {
        joint._localMatrix = joint._bindPoseMatrix * _tempMatrix.setFromTranslationRotation(pos, rot);
      } else {
        joint._localMatrix.setFromTranslationRotation(pos, rot);
      }
      if (startframe.scaling != null && endframe.scaling != null) {
        var scaling = lerp(startframe.scaling, endframe.scaling, percent);
        joint._localMatrix.scale(scaling);
      }
    });
    skeleton._dirtyJoints = true;
    _mesh.skeleton = skeleton;
  }

  AnimationController clone(Mesh mesh) {
    var result = new AnimationController(mesh);
    result.animations = animations;
    return result;
  }
}













