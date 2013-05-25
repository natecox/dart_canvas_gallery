library dart_canvas_gallery;

import "dart:html";
import "dart:math";
import "package:web_ui/web_ui.dart";
import "package:game_loop/game_loop_html.dart";

part "gallery_element.dart";
part "analog_clock.dart";
part "rings.dart";
part "gallery.dart";
part "spinning_square.dart";

Gallery gallery;
List<String> galleryItems;

void main() {
  gallery = new Gallery();
  galleryItems = toObservable(new List<String>());
  gallery.elements.keys.forEach((i) => galleryItems.add(i));

  gallery.swapTo(galleryItems.last);
}