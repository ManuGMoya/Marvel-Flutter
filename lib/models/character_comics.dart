import 'comic_summary.dart';

class CharacterComics {
  final int? available;
  final int? returned;
  final String? collectionURI;
  final List<ComicSummary>? items;

  CharacterComics(
      {this.available, this.returned, this.collectionURI, this.items});

  factory CharacterComics.fromJson(Map<String, dynamic> json) {
    return CharacterComics(
      available: json['available'],
      returned: json['returned'],
      collectionURI: json['collectionURI'],
      items:
          (json['items'] as List).map((i) => ComicSummary.fromJson(i)).toList(),
    );
  }
}
