class Image {
  final String? path;
  final String? extension;

  Image({this.path, this.extension});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      path: json['path'] as String?,
      extension: json['extension'] as String?,
    );
  }
}