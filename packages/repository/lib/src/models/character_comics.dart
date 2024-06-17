import 'package:repository/src/models/comic_summary.dart';

/// Represents the comics related to a Marvel character.
///
/// Each `CharacterComics` instance has an [available] count, a [returned]
/// count, a [collectionURI], and a list of [items] which are `ComicSummary`
/// instances.
class CharacterComics {
  /// Creates a new `CharacterComics` instance.
  ///
  /// All parameters are optional.
  CharacterComics({
    this.available,
    this.returned,
    this.collectionURI,
    this.items,
  });

  /// Creates a new `CharacterComics` instance from a map.
  ///
  /// This factory constructor allows for easy deserialization from JSON.
  factory CharacterComics.fromJson(Map<String, dynamic> json) {
    return CharacterComics(
      available: json['available'] as int?,
      returned: json['returned'] as int?,
      collectionURI: json['collectionURI'] as String?,
      items: (json['items'] as List)
          .map((i) => ComicSummary.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  /// The number of comics available for this character.
  final int? available;

  /// The number of comics returned for this character.
  final int? returned;

  /// The URI for the collection of comics for this character.
  final String? collectionURI;

  /// The list of comic summaries for this character.
  final List<ComicSummary>? items;
}
