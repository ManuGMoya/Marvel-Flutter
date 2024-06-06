class ComicSummary {
  final String? resourceURI;
  final String? name;

  ComicSummary({this.resourceURI, this.name});

  factory ComicSummary.fromJson(Map<String, dynamic> json) {
    return ComicSummary(
      resourceURI: json['resourceURI'],
      name: json['name'],
    );
  }
}