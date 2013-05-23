library dart_canvas_gallery;

import "dart:html";
import "dart:math";

part "gallery_element.dart";
part "analog_clock.dart";
part "rings.dart";

Rings r;
void main() {
  r = new Rings(query("#gallery"));
  r.render();
}