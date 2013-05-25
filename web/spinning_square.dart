part of dart_canvas_gallery;

class SpinningSquare extends GalleryElement {
  double centerX, centerY;

  SpinningSquare(CanvasElement canvas, CanvasRenderingContext2D context)
      : super("Spinning Square", "", canvas, context);

  void update(GameLoopHtml gameLoop) {
    centerX = canvas.width / 2;
    centerY = canvas.height / 2;
  }

  void render(GameLoopHtml gameLoop) {
    context.setFillColorRgb(0, 0, 0, 1);
    context.fillRect(0, 0, canvas.width, canvas.height);

    context.translate(centerX, centerY);
    context.rotate(PI / 180);
    context.translate(-centerX, -centerY);

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