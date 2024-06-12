import 'package:marvel_flutter/models/image.dart';

class Comic {
  final int? id;
  final String? title;
  final List<DateDto>? dates;
  final Image? thumbnail;

  Comic({this.id, this.title, this.dates, this.thumbnail});

  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'],
      title: json['title'],
      dates: (json['dates'] as List).map((i) => DateDto.fromJson(i)).toList(),
      thumbnail: Image.fromJson(json['thumbnail']),
    );
  }
}

class DateDto {
  final String? type;
  final DateTime? date;

  DateDto({this.type, this.date});

  factory DateDto.fromJson(Map<String, dynamic> json) {
    return DateDto(
      type: json['type'],
      date: DateTime.parse(json['date']),
    );
  }
}
