library dart_canvas_gallery;

import "dart:html";
import "analog_clock.dart";
import "rings.dart";

AnalogClock clock;
void main() {
  clock = new AnalogClock(query("#gallery"));
  clock.render();
}