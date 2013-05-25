part of dart_canvas_gallery;

/// A basic Ring object.
///
/// Specifies location and size to draw the Ring, and the amount by
/// which to resize it.
class Ring {
  int x, y, red, green, blue;
  double radius, maxRadius, multiplier, alpha;

  Ring(this.x, this.y, this.radius, this.maxRadius,
      [this.red = 255, this.green = 255, this.blue = 255, this.alpha = 1.0,
      this.multiplier = 1.0]);
}

/// Specifies the mechanics of drawing animated [Ring]s to a canvas element.
///
/// The constructor accepts the canvas element to draw to, which must be
/// present in the DOM before creating an instance of Rings.
class Rings extends GalleryElement {

  /// Random number generator
  final Random rng = new Random();

  /// A list of ring objects.
  List<Ring> rings;

  /// Class constructor.
  ///
  /// Constructor sets the context and generates the [Ring] objects,
  /// but does not start the rendering process.
  ///
  /// ##Arguments:
  /// 1. [canvas]: requires a reference to a canvas element from the dom.
  /// 2. [context]: requires a context on which to draw.
  /// 3. [maxRings]: the maximum number of rings to render.
  Rings(CanvasElement canvas, CanvasRenderingContext2D context, [int maxRings = 100])
      : super("Rings", "", canvas, context) {
    // Populate the list of rings with randomized starting positions.
    generateRings((sqrt(pow(canvas.width, 2) + pow(canvas.height, 2)) / 2).floor());
  }

  /// Populates a list with randomly sized and positioned [Ring] objects.
  ///
  /// This function must be called before attempting to render to the [canvas].
  void generateRings(int maxRings) {
    // Define our list as a list of Ring objects with no maximum size.
    rings = new List<Ring>(maxRings);

    // To hold the [Ring]'s details
    int x, y;
    double radius, maxRadius, multiplier;

    // Specify a buffer zone not to center rings in, to keep them off the edges
    int xBuffer = (canvas.width * .1).round();
    int yBuffer = (canvas.height * .1).round();

    // Populate our list of [Ring]s by specifying them one at a time.
    for (int i = 0; i < maxRings; i++) {
      // Set a safe coordinate for the ring.
      x = rng.nextInt(canvas.width - (xBuffer * 2)) + xBuffer;
      y = rng.nextInt(canvas.height - (yBuffer * 2)) + yBuffer;

      // Now that we know the x and y coordinates of the ring's center
      // we can determine the maximum radius this ring can achieve before it
      // collides with the edge of the canvas.
      maxRadius = [x, y, canvas.width - x, canvas.height - y]
        .reduce(min)
        .toDouble();

      // Set a random starting radius
      radius = rng.nextDouble() * maxRadius;

      // Set a multiplier somewhere between 0.5 and 2.5.
      multiplier = (rng.nextDouble() * 2.0) + 0.5;

      // Create a new [Ring] and specify the details in the constructor.
      rings[i] = new Ring(x, y, radius, maxRadius,
          255, 255, 255, 1.0, multiplier);
    }
  }

  void update(GameLoopHtml loop) {
    for (Ring ring in rings) {
      // Modify the [Ring]'s radius by the value of its multiplier.
      ring.radius += ring.multiplier;

      // Determine if the ring is expanding or collapsing.
      // If expanding, then continue until the [Ring] is larger than
      // it's maximum radius then reset to the maximum radius and
      // flip the multiplier to decrement.
      // If collapsing, continue until the [Ring] has a radius of less than
      // 1, then reset the radius to 1 and flip the multiplier to increment.
      if (ring.multiplier > 0) {
        if (ring.radius > ring.maxRadius) {
          ring.radius = ring.maxRadius;
          ring.multiplier *= -1.0;
        }
      } else {
        if (ring.radius < 1) {
          ring.radius = 1.0;
          ring.multiplier *= -1.0;
        }
      }
    }
  }

  /// Processes the animation.
  ///
  /// This function processes each [Ring] object in the populated list.
  /// Each time this function is called it will expand or collapse
  /// each ring accordingly and set the color of the [Ring] according to
  /// its percentage of radius to maxRadius.
  void render(GameLoopHtml loop) {
    // Start by clearing the screen
    context.setFillColorRgb(0, 0, 0, 1);
    context.fillRect(0, 0, canvas.width, canvas.height);

    // Process each [Ring] independently.
    for (Ring ring in rings) {
      // To fade the ring, get the percentage of current radius to
      // maximum radius. Setting the ring's alpha to this gives you
      // full translucency at radius 0 and total opacity at maximum radius.
      double pctAlpha = ring.radius / ring.maxRadius;
      ring.alpha = pctAlpha;

      // To draw the ring (a circle), we specify an arc with 360 degrees drawn.
      context.beginPath();
      context.arc(ring.x, ring.y, ring.radius, 0, PI * 2, false);
      context.closePath();

      // Set the stroke (i.e., line) color to the Ring's specifications.
      context.setStrokeColorRgb(ring.red, ring.green, ring.blue, ring.alpha);

      // Draw the arc as specified.
      context.stroke();
    }
  }
}