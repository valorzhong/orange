part of orange;



class Joint extends Node {
  int jointId;
  int parentId;
  Matrix4 _bindPoseMatrix;
  Matrix4 _inverseBindMatrix;

  @override
  updateMatrix([bool updateChildren = true]) {
    super.updateMatrix(updateChildren);
    if (_bindPoseMatrix == null) {
      _bindPoseMatrix = _localMatrix.clone();
    }
    if (_inverseBindMatrix == null) {
      _inverseBindMatrix = worldMatrix.clone();
      _inverseBindMatrix.invert();
    }
  }
  
  @override
  String toString() {
    return "Joint:'$id', ID:'$jointId', Parent:'$parentId'";
  }
}
