part of dart_canvas_gallery;

/* TODO
 *
 * Need to change design to either create a separate canvas element for each
 * gallery element (not desirable) or to find a way to totally clear and reset
 * the canvas on swap.
 *
 * Best option may be to have the swap destroy and recreate the canvas element.
 */

class Gallery {
  GameLoopHtml game;
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  Map<String, GalleryElement> elements;
  String currentName;
  String currentDescription;

  Gallery() {
    canvas = query('#gCanvas');
    canvas.width = canvas.clientWidth;
    canvas.height = canvas.clientHeight;

    game = new GameLoopHtml(canvas);
    context = canvas.context2D;

    game.start();


    elements = new Map<String, GalleryElement>();

    GalleryElement g;
    g = new Rings(canvas, context);
    elements[g.displayName] = g;
    g = new AnalogClock(canvas, context);
    elements[g.displayName] = g;
  }

  void swapTo(String name) {
    currentName = name;
    currentDescription = elements[name].description;
    context.setTransform(1, 0, 0, 1, 0, 0);
    game.onUpdate = elements[name].update;
    game.onRender = elements[name].render;
  }
}