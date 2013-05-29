part of dart_canvas_gallery;

/**
 * Contains all the information nessisary to draw an analog clock to a given canvas element.
 */
class AnalogClock extends GalleryElement {
  /// The radius of the entire clock face.
  double clockRadius;
  /// The x position of the center of the clock face.
  double centerX;
  /// The y position of the center of the clock face.
  double centerY;
  final double anglePerSecond = 360 / 60;
  final double anglePerMinute = 360 / 60;
  final double anglePerHour = 360 / 12;

  /**
   * Class constructor
   *
   * Sets all of the class properties, most of which originate from the canvas element.
   * Also rotates the rendering context for correct display of time.
   */
  AnalogClock(CanvasElement canvas, CanvasRenderingContext2D context)
      : super("Analog Clock", "A simple clock generated entirely with paths.", canvas, context);

  void update(GameLoopHtml loop) {
    canvas.width = canvas.clientWidth;
    canvas.height = canvas.clientHeight;
    clockRadius = min(canvas.width, canvas.height) * 0.49;
    centerX = canvas.width / 2;
    centerY = canvas.height / 2;
  }

  /**
   * Renders the image to the canvas context.
   *
   * Processes the details of drawing the clock face and hands.
   */
  void render(GameLoopHtml loop) {
    // Set the current date and time
    final DateTime date = new DateTime.now();

    context.save();

    // Clear the context.
    context.clearRect(0, 0, canvas.width, canvas.height);
    context.lineWidth = 3;

    // Start drawing the outline and minute marker path.
    context.beginPath();
    context.arc(canvas.width / 2, canvas.height / 2, clockRadius, 0, PI * 2, false);
    context.closePath();
    context.setFillColorRgb(255, 255, 255, 1);
    context.fill();

    // Draw the minute markers
    for (int i = 0; i < 60; i++) {
      context.save();
      // Determine the length of the minute marker for ease of reading.
      int markLength;
      if (i % 15 == 0) { markLength = 30; }
      else if (i % 5 == 0) { markLength = 20; }
      else { markLength = 10; }

      // Determine the angle from 0 to this minute marker;
      double angle = anglePerMinute * i;

      // Use cosine to get the ratio of the side adjacent to the hypotenuse.
      double adjRatio = adjacentRatio(angle);

      // Use sine to get the ratio of the side opposite of the hypotenuse;
      double oppRatio = oppositeRatio(angle);

      // Get the outermost position of the minute marker.
      double outerX = (clockRadius * adjRatio);
      double outerY = (clockRadius * oppRatio);

      // Get the innermost position of the minute marker.
      double innerX = ((clockRadius - markLength) * adjRatio);
      double innerY = ((clockRadius - markLength) * oppRatio);

      // Start the path, move to the inner position, draw to the outer, then close and stroke.
      context.translate(centerX, centerY);
      context.beginPath();
      context.moveTo(innerX, innerY);
      context.lineTo(outerX, outerY);
      context.closePath();
      context.setStrokeColorRgb(0, 0, 0, 1);
      context.stroke();

      context.restore();
    }

    // Draw the clock hands.
    drawClockHand((anglePerHour * date.hour), clockRadius - 50, 0, 0, 255);
    drawClockHand((anglePerMinute * date.minute), clockRadius - 20, 255, 0, 0);
    drawClockHand((anglePerSecond * date.second), clockRadius, 0, 255, 0);

    // Draw the clock outline last so that it can cover the edges of the clock hands
    context.beginPath();
    context.arc(canvas.width / 2, canvas.height / 2, clockRadius, 0, PI * 2, false);
    context.closePath();
    context.setStrokeColorRgb(0, 0, 0, 1);
    context.stroke();

    context.restore();
  } // AnalogClock.render()

  /**
   * Draws a line from the center of the clock face to the edge.
   *
   * Angle provided will determine the position of the line.
   */
  void drawClockHand(double angle, double length, int red, int green, int blue) {
    context.save();
    context.translate(centerX, centerY);
    context.rotate((3 * PI) / 2);
    context.translate(-centerX, -centerY);

    // Get the ratio of the sides to radius.
    double adjRatio = adjacentRatio(angle);
    double oppRatio = oppositeRatio(angle);

    // Get the position data for the minute hand.
    double x = ((length * adjRatio) + centerX);
    double y = ((length * oppRatio) + centerY);

    // Draw the minute hand in red.
    context.beginPath();
    context.moveTo(centerX, centerY);
    context.lineTo(x, y);
    context.closePath();
    context.setStrokeColorRgb(red, green, blue, 1);
    context.stroke();

    context.restore();
  }

  /**
   * Returns the ratio of the adjacent side to the hypotenuse.
   */
  double adjacentRatio(double angle) { return cos(angle * (PI / 180)); }

  /**
   * Returns the ratio of the opposite side to the hypotenuse.
   */
  double oppositeRatio(double angle) { return sin(angle * (PI / 180)); }

} // AnalogClock
