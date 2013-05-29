library dart_canvas_gallery;

import "dart:html";
import "dart:math";
import "package:web_ui/web_ui.dart";
import "package:game_loop/game_loop_html.dart";

part "common/color.dart";
part "gallery/gallery.dart";
part "gallery/gallery_element.dart";
part "gallery/gallery_elements/analog_clock.dart";
part "gallery/gallery_elements/rings.dart";

Gallery gallery;
List<String> galleryItems;

void main() {
  gallery = new Gallery();
  galleryItems = toObservable(new List<String>());
  gallery.elements.keys.forEach((i) => galleryItems.add(i));

  gallery.swapTo(galleryItems.last);
}
