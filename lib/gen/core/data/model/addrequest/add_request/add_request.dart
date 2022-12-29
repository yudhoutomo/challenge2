import 'package:json_annotation/json_annotation.dart';

part '../../../../../gen/core/data/model/addrequest/add_request/add_request.g.dart';

@JsonSerializable()
class AddRequest {
  @JsonKey(name: 'message')
  String? message = '';

  AddRequest({this.message});

  factory AddRequest.fromJson(json) {
    return _$AddRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddRequestToJson(this);
}
