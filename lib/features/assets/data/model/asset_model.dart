import 'dart:convert';

import '../../../../utils/constants/constants.dart';

class AssetModel {
  AssetModel({
    required this.id,
    this.gatewayId,
    this.locationId,
    required this.name,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
  });

  final String id;
  final String? gatewayId;
  final String? locationId;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;

  AssetModel copyWith({
    String? id,
    String? gatewayId,
    String? locationId,
    String? name,
    String? parentId,
    String? sensorId,
    String? sensorType,
    String? status,
  }) {
    return AssetModel(
      id: id ?? this.id,
      gatewayId: gatewayId ?? this.gatewayId,
      locationId: locationId ?? this.locationId,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      sensorId: sensorId ?? this.sensorId,
      sensorType: sensorType ?? this.sensorType,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      kId: id,
      kGatewayId: gatewayId,
      kLocationId: locationId,
      kName: name,
      kParentId: parentId,
      kSensorId: sensorId,
      kSensorType: sensorType,
      kStatus: status,
    };
  }

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      id: map[kId] as String,
      gatewayId: map[kGatewayId] != null ? map[kGatewayId] as String : null,
      locationId: map[kLocationId] != null ? map[kLocationId] as String : null,
      name: map[kName] as String,
      parentId: map[kParentId] != null ? map[kParentId] as String : null,
      sensorId: map[kSensorId] != null ? map[kSensorId] as String : null,
      sensorType: map[kSensorType] != null ? map[kSensorType] as String : null,
      status: map[kStatus] != null ? map[kStatus] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetModel.fromJson(String source) =>
      AssetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AssetModel(id: $id, gatewayId: $gatewayId, locationId: $locationId, name: $name, parentId: $parentId, sensorId: $sensorId, sensorType: $sensorType, status: $status)';
  }

  @override
  bool operator ==(covariant AssetModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.gatewayId == gatewayId &&
        other.locationId == locationId &&
        other.name == name &&
        other.parentId == parentId &&
        other.sensorId == sensorId &&
        other.sensorType == sensorType &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        gatewayId.hashCode ^
        locationId.hashCode ^
        name.hashCode ^
        parentId.hashCode ^
        sensorId.hashCode ^
        sensorType.hashCode ^
        status.hashCode;
  }
}
