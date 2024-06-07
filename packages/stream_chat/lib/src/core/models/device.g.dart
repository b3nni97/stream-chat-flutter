// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
      id: json['id'] as String,
      pushProvider: json['push_provider'] as String,
      disabled: json['disabled'] as bool?,
      disabledReason: json['disabled_reason'] as String?,
    );

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'id': instance.id,
      'push_provider': instance.pushProvider,
      'disabled': instance.disabled,
      'disabled_reason': instance.disabledReason,
    };
