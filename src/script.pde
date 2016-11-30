var shapes;

void setup() {
  size(window.innerWidth, window.innerHeight);
  smooth(8);
  frameRate(60);

  shapes = [
    cuboid(-120, -20, -20, 240, 40, 40),
    cuboid(-120, -50, -30, -20, 100, 60),
    cuboid( 120, -50, -30,  20, 100, 60)
  ];
}

var draw() {
  var nodes, edges;

  background(color(255, 255, 255));
  translate(width/2, height/2);

  stroke(color(34, 68, 204));
  for (var shapeNum = 0; shapeNum < shapes.length; shapeNum++) {
    nodes = shapes[shapeNum].nodes;
    edges = shapes[shapeNum].edges;
    for (var e = 0; e < edges.length; e++) {
      var n0 = edges[e][0];
      var n1 = edges[e][1];
      var node0 = nodes[n0];
      var node1 = nodes[n1];
      line(node0[0], node0[1], node1[0], node1[1]);
    }
  }

  fill(color(40, 168, 107));
  noStroke();
  for (var shapeNum = 0; shapeNum < shapes.length; shapeNum++) {
    nodes = shapes[shapeNum].nodes;
    for (var n = 0; n < nodes.length; n++) {
      var node = nodes[n];
      ellipse(node[0], node[1], 8, 8);
    }
  }
}

void mouseDragged() {
  var dx = (mouseX - pmouseX) * 0.01;
  var dy = (mouseY - pmouseY) * 0.01;

  for (var shapeNum = 0; shapeNum < shapes.length; shapeNum++) {
    var nodes = shapes[shapeNum].nodes;
    rotateY3D(dx, nodes);
    rotateX3D(dy, nodes);
  }
}

void cuboid(x, y, z, w, h, d) {
  var nodes = [
    [x, y, z],
    [x, y, z+d],
    [x, y+h, z],
    [x, y+h, z+d],
    [x+w, y, z],
    [x+w, y, z+d],
    [x+w, y+h, z],
    [x+w, y+h, z+d]
  ];

  var edges = [
    [0, 1], [1, 3], [3, 2], [2, 0],
    [4, 5], [5, 7], [7, 6], [6, 4],
    [0, 4], [1, 5], [2, 6], [3, 7]
  ];

  var cuboid = { 'nodes': nodes, 'edges': edges };
  return cuboid;
}

void rotateZ3D(theta, nodes) {
  var sinTheta = sin(theta);
  var cosTheta = cos(theta);

  for (var n = 0; n < nodes.length; n++) {
    var node = nodes[n];
    var x = node[0];
    var y = node[1];
    node[0] = x * cosTheta - y * sinTheta;
    node[1] = y * cosTheta + x * sinTheta;
  }
}

void rotateY3D(theta, nodes) {
  var sinTheta = sin(theta);
  var cosTheta = cos(theta);

  for (var n = 0; n < nodes.length; n++) {
    var node = nodes[n];
    var x = node[0];
    var z = node[2];
    node[0] = x * cosTheta - z * sinTheta;
    node[2] = z * cosTheta + x * sinTheta;
  }
}

void rotateX3D(theta, nodes) {
  var sinTheta = sin(theta);
  var cosTheta = cos(theta);

  for (var n = 0; n < nodes.length; n++) {
    var node = nodes[n];
    var y = node[1];
    var z = node[2];
    node[1] = y * cosTheta - z * sinTheta;
    node[2] = z * cosTheta + y * sinTheta;
  }
}
