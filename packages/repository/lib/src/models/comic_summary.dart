/// Represents a summary of a Comic in the Marvel Universe.
///
/// Each `ComicSummary` instance has a [resourceURI] and a [name].
class ComicSummary {
  /// Creates a new `ComicSummary` instance.
  ///
  /// All parameters are optional.
  ComicSummary({this.resourceURI, this.name});

  /// Creates a new `ComicSummary` instance from a map.
  ///
  /// This factory constructor allows for easy deserialization from JSON.
  factory ComicSummary.fromJson(Map<String, dynamic> json) {
    return ComicSummary(
      resourceURI: json['resourceURI'] as String?,
      name: json['name'] as String?,
    );
  }

  /// The resource URI of the comic.
  final String? resourceURI;

  /// The name of the comic.
  final String? name;
}
