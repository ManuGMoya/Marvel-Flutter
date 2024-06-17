/// Represents an Image in the Marvel Universe.
///
/// Each `Image` instance has a [path] and an [extension].
class Image {
  /// Creates a new `Image` instance.
  ///
  /// Both parameters are optional.
  Image({this.path, this.extension});

  /// Creates a new `Image` instance from a map.
  ///
  /// This factory constructor allows for easy deserialization from JSON.
  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      path: json['path'] as String?,
      extension: json['extension'] as String?,
    );
  }

  /// The path of the image.
  final String? path;

  /// The extension of the image.
  final String? extension;
}
