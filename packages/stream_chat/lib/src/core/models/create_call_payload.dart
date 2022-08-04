import 'package:equatable/equatable.dart';
import 'package:stream_chat/src/core/models/call_payload.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';


part 'create_call_payload.g.dart';
@JsonSerializable(includeIfNull: false)
class CreateCallPayload extends Equatable {
  final CallPayload call;
  const CreateCallPayload({required this.call});

  factory CreateCallPayload.fromJson(Map<String, dynamic> json) =>
      _$CreateCallPayloadFromJson(json);

  @override
  List<Object?> get props => [call];
}
