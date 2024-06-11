import 'comic_list.dart';
import 'image.dart';

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
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnail: Image.fromJson(json['thumbnail']),
      comics: ComicList.fromJson(json['comics']).available,
    );
  }
}
