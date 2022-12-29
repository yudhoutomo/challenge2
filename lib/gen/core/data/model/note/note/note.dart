import 'package:json_annotation/json_annotation.dart';
part '../../../../../gen/core/data/model/note/note/note.g.dart';

@JsonSerializable()
class Note {
  @JsonKey(name: 'id')
  String id = "";

  @JsonKey(name: 'title')
  String title = "";

  @JsonKey(name: 'content')
  String content = "";
  @JsonKey(name: 'created_at')
  int createdAt = 0;
  @JsonKey(name: 'updated_at')
  int updatedAt = 0;

  Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.updatedAt});

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}
