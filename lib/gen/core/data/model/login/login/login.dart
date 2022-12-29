import 'package:json_annotation/json_annotation.dart';
part '../../../../../gen/core/data/model/login/login/login.g.dart';

@JsonSerializable()
class Login {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'email')
  String? email;

  Login({this.id, this.name, this.email});

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
