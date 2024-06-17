import 'package:repository/src/models/character_comics.dart';
import 'package:repository/src/models/image.dart';

/// Represents a Marvel character.
///
/// Each character has an [id], a [name], a [description], a [thumbnail], and
/// a count of [comics] they appear in.
class Character {
  /// Creates a new character instance.
  ///
  /// All parameters are optional.
  Character({
    this.id,
    this.name,
    this.description,
    this.thumbnail,
    this.comics,
  });

  /// Creates a new character instance from a map.
  ///
  /// This factory constructor allows for easy deserialization from JSON.
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      thumbnail: Image.fromJson(json['thumbnail'] as Map<String, dynamic>),
      comics: CharacterComics.fromJson(json['comics'] as Map<String, dynamic>)
          .available,
    );
  }

  /// The unique ID of the character.
  final int? id;

  /// The name of the character.
  final String? name;

  /// A description of the character.
  final String? description;

  /// The character's thumbnail image.
  final Image? thumbnail;

  /// The number of comics the character appears in.
  final int? comics;
}
