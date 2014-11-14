// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of orange;


class MeshRenderer extends Component {
  
  @override
  void start() {
    // TODO: implement start
  }

  @override
  void update(GameTime time) {
    // TODO: implement update
  }
  
  void render() {
    if(_target.meshFilter == null || _target.meshFilter.sharedMesh == null)
      return;
    
    var mesh = _target.meshFilter.sharedMesh;
    mesh.materials;
    
  }
}