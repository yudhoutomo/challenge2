import 'package:json_annotation/json_annotation.dart';

part '../../../../../gen/core/data/model/profile/profile/profile.g.dart';

@JsonSerializable()
class Profile {
  @JsonKey(name: 'id')
  String? id = '';

  @JsonKey(name: 'name')
  String name = '';

  @JsonKey(name: 'email')
  String email = '';

  @JsonKey(name: 'photo')
  String photo = '';

  Profile(
      {this.id, required this.name, required this.email, required this.photo});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return _$ProfileFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
