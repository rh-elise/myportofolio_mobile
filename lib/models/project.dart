import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Project {
  const Project({
    required this.title,
    required this.description,
    required this.image,
    this.link = '',
    this.id,
    this.starCount = 0,
    this.isStarred = false,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  @JsonKey(includeToJson: false)
  final int? id;

  final String title;

  final String description;

  final String image;

  @JsonKey(defaultValue: '')
  final String link;

  @JsonKey(includeToJson: false)
  final int starCount;

  @JsonKey(includeToJson: false)
  final bool isStarred;

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
