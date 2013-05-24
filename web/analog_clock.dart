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

  /**
   * Class constructor
   *
   * Sets all of the class properties, most of which originate from the canvas element.
   * Also rotates the rendering context for correct display of time.
   */
  AnalogClock(CanvasElement canvas, CanvasRenderingContext2D context) {
    this.displayName = "Analog Clock";
    this.description = "An example of using arcs and trig to make a clock";
    this.canvas = canvas;
    this.context = context;

    this.clockRadius = min(canvas.width, canvas.height) * 0.49;
    this.centerX = canvas.width / 2;
    this.centerY = canvas.height / 2;

    // Arc (circle) origins always start at the right side, which makes
    // the math for rendering the clock hard.
    // Make it easier by just rotating the entire canvas -45 degrees.
    // context.translate(centerX, centerY);
    // context.rotate((3 * PI) / 2);
    // context.translate(-centerX, -centerY);
  }

  /**
   * Renders the image to the canvas context.
   *
   * Processes the details of drawing the clock face and hands.
   */
  void render(GameLoopHtml loop) {
    // Set the current date and time
    final DateTime date = new DateTime.now();

    // Set the number of degrees between clock markers.
    final double anglePerSecond = 360 / 60;
    final double anglePerMinute = 360 / 60;
    final double anglePerHour = 360 / 12;

    // Clear the context.
    context.setFillColorRgb(255, 255, 255, 1);
    context.fillRect(0, 0, canvas.width, canvas.height);

    // Start drawing the outline and minute marker path.
    context.beginPath();

    // Draw the outline of the clock.
    context.arc(canvas.width / 2, canvas.height / 2, clockRadius, 0, PI * 2, false);

    // Draw the minute markers
    for (int i = 0; i < 60; i++) {
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
      double outerX = (clockRadius * adjRatio) + centerX;
      double outerY = (clockRadius * oppRatio) + centerY;

      // Get the innermost position of the minute marker.
      double innerX = ((clockRadius - markLength) * adjRatio) + centerX;
      double innerY = ((clockRadius - markLength) * oppRatio) + centerY;

      // Start the path, move to the inner position, draw to the outer, then close and stroke.
      context.moveTo(innerX, innerY);
      context.lineTo(outerX, outerY);
    }

    // Foundation path is set, stroke it.
    context.setStrokeColorRgb(0, 0, 0, 1);
    context.stroke();

    // Draw the clock hands.
    drawClockHand((anglePerHour * date.hour), clockRadius - 50, 0, 0, 255);
    drawClockHand((anglePerMinute * date.minute), clockRadius - 20, 255, 0, 0);
    drawClockHand((anglePerSecond * date.second), clockRadius, 0, 255, 0);
  } // AnalogClock.render()

  /**
   * Draws a line from the center of the clock face to the edge.
   *
   * Angle provided will determine the position of the line.
   */
  void drawClockHand(double angle, double length, int red, int green, int blue) {
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
