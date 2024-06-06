import 'comic_summary.dart';

class ComicList {
  final int? available;
  final int? returned;
  final String? collectionURI;
  final List<ComicSummary>? items;

  ComicList({this.available, this.returned, this.collectionURI, this.items});

  factory ComicList.fromJson(Map<String, dynamic> json) {
    return ComicList(
      available: json['available'],
      returned: json['returned'],
      collectionURI: json['collectionURI'],
      items: (json['items'] as List).map((i) => ComicSummary.fromJson(i)).toList(),
    );
  }
}