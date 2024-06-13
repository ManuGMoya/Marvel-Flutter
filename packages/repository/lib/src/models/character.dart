import 'package:repository/src/models/character_comics.dart';
import 'package:repository/src/models/image.dart';

class Character {
  final int? id;
  final String? name;
  final String? description;
  final Image? thumbnail;
  final int? comics;

  Character(
      {this.id, this.name, this.description, this.thumbnail, this.comics});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      thumbnail: Image.fromJson(json['thumbnail'] as Map<String, dynamic>),
      comics: CharacterComics.fromJson(json['comics'] as Map<String, dynamic>).available,
    );
  }
}