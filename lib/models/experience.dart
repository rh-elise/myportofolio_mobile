import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    required this.title,
    required this.description,
    required this.category,
    required this.year,
    required this.status,
    this.thumbnail = '',
    this.id,
    this.starCount = 0,
    this.isStarred = false,
    this.starredByNames = '',
  });

  factory Experience.fromJson(Map<String, dynamic> json) =>
      _$ExperienceFromJson(json);

  @JsonKey(includeToJson: false)
  final int? id;

  final String title;

  final String description;

  final String category;

  @JsonKey(defaultValue: '')
  final String thumbnail;

  final int year;

  final String status;

  @JsonKey(includeToJson: false)
  final int starCount;

  @JsonKey(includeToJson: false)
  final bool isStarred;

  @JsonKey(includeToJson: false, defaultValue: '')
  final String starredByNames;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}
