part of dart_canvas_gallery;

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
    context = canvas.getContext("2d");

    game = new GameLoopHtml(canvas);
    game.handleMouseEvents = true;
    game.start();


    elements = new Map<String, GalleryElement>();
    elements["Analog Clock"] = new AnalogClock(canvas, context);
    elements["Rings"] = new Rings(canvas, context);
  }

  void swapTo(String name) {
    currentName = name;
    currentDescription = elements[name].description;
    context.setTransform(1, 0, 0, 1, 0, 0);
    game.onUpdate = elements[name].update;
    game.onRender = elements[name].render;
  }
}