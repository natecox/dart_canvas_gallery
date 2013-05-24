part of dart_canvas_gallery;

abstract class GalleryElement {
  String displayName;
  String description;
  
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  
  GalleryElement(this.displayName, this.description, this.canvas, this.context);
  
  render(GameLoopHtml gameLoop);
}