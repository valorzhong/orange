// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of orange;



class Mesh {

  VertexBuffer _vertexBuffer;
  VertexBuffer _normalBuffer;
  VertexBuffer _texCoordsBuffer;
  VertexBuffer _texCoords2Buffer;
  VertexBuffer _indexBuffer;
  
  

  void computeNormals() {
    // TODO
  }

  void computeTangentSpace([bool normals]) {
    // TODO
  }
  
  Mesh clone() {
    var mesh = new Mesh();
    // TODO
    return mesh;
  }
}
