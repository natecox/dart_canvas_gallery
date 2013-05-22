library dart_canvas_gallery;

import "dart:html";
import "dart:math";

part "gallery_element.dart";
part "analog_clock.dart";
part "rings.dart";

AnalogClock clock;
void main() {
  clock = new AnalogClock(query("#gallery"));
  clock.render();
}