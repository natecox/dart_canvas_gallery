part of dart_canvas_gallery;

class SpinningSquare extends GalleryElement {

  SpinningSquare(CanvasElement canvas, CanvasRenderingContext2D context) {
    this.displayName = "Spinning Square";
    this.description = "A demo of canvas rotation.";
    this.canvas = canvas;
    this.context = context;
  }

  void render(GameLoopHtml gameLoop) {
    // rotate the canvas one degree.
    double centerX = canvas.width / 2;
    double centerY = canvas.height / 2;
    context.translate(centerX, centerY);
    context.rotate(PI / 180);
    context.translate(-centerX, -centerY);

    context.setFillColorRgb(0, 0, 0, 1);
    context.fillRect(0, 0, canvas.width, canvas.height);

    context.setFillColorRgb(255, 0, 0, 1);
    context.fillRect(canvas.width / 4, canvas.height / 4, canvas.width / 4, canvas.height / 4);

    context.setFillColorRgb(0, 255, 0, 1);
    context.fillRect(canvas.width / 4, canvas.height / 2, canvas.width / 4, canvas.height / 4);

    context.setFillColorRgb(0, 0, 255, 1);
    context.fillRect(canvas.width / 2, canvas.height / 4, canvas.width / 4, canvas.height / 4);

    context.setFillColorRgb(255, 255, 255, 1);
    context.fillRect(canvas.width / 2, canvas.height / 2, canvas.width / 4, canvas.height / 4);
  }
}