import 'package:repository/src/models/comic_summary.dart';

class CharacterComics {
  final int? available;
  final int? returned;
  final String? collectionURI;
  final List<ComicSummary>? items;

  CharacterComics(
      {this.available, this.returned, this.collectionURI, this.items});

  factory CharacterComics.fromJson(Map<String, dynamic> json) {
    return CharacterComics(
      available: json['available'] as int?,
      returned: json['returned'] as int?,
      collectionURI: json['collectionURI'] as String?,
      items: (json['items'] as List).map((i) => ComicSummary.fromJson(i as Map<String, dynamic>)).toList(),
    );
  }
}