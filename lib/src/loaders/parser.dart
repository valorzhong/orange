part of orange;



class Parser {
  
  static parseSkeleton(Map doc) {
    var skeleton = new Skeleton();
    skeleton.joints = [];
    doc["joints"].forEach((j) {
      var joint = new Joint();
      joint.id = j["id"];
      if(j.containsKey("parent")) {
        joint.parentId = j["parent"];
      } else {
        joint.parentId = -1;
      }
      joint.name = j["name"];
      joint.position = new Vector3.fromList(j["position"]);
      var rot = j["rotation"];
      joint.rotation = parseRotation(rot);
      skeleton.joints.add(joint);
    });
    skeleton.buildHierarchy();
    return skeleton;
  }
  
  static parseAnimation(Map doc) {
    var animation = new Animation();
    animation.name = doc["name"];
    animation.length = doc["length"].toDouble();
    animation.tracks = [];
    doc["tracks"].forEach((t) {
      var track = new Track();
      track.jointName = t["joint"];
      track.keyframes = [];
      t["keyframes"].forEach((k) {
        var keyframe = new Keyframe();
        keyframe.time = k["time"];
        keyframe.rotate = parseRotation(k["rotate"]);
        keyframe.translate = new Vector3.fromList(k["translate"]);
        track.keyframes.add(keyframe);
      });
      animation.tracks.add(track);
    });
    return animation;
  }
  
  static parseRotation(Map rot) => new Quaternion.axisAngle(new Vector3.fromList(rot["axis"]), rot["angle"]);
  
}
















