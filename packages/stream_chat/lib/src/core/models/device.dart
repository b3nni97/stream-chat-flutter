import 'package:json_annotation/json_annotation.dart';

part 'device.g.dart';

/// The class that contains the information about a device
@JsonSerializable()
class Device {
  /// Constructor used for json serialization
  Device({
    required this.id,
    required this.pushProvider,
    this.disabled,
    this.disabledReason,
  });

  /// Create a new instance from a json
  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  /// The id of the device
  final String id;

  /// The notification push provider
  final String pushProvider;

  /// Wether the push notifications for this device are disabled
  final bool? disabled;

  /// The reason why the push notifications are disabled
  final String? disabledReason;


  /// Serialize to json
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
