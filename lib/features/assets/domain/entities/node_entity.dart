enum NodeType { location, subLocation, asset, subAsset, component }

enum NodeStatus { operating, alert, none }

class NodeEntity {
  NodeEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.nodes,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.locationId,
  });

  final String id;
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final NodeStatus? status;
  final String? gatewayId;
  final String? locationId;
  final NodeType type;
  List<NodeEntity> nodes;

  NodeEntity copyWith({
    String? id,
    String? name,
    String? parentId,
    String? sensorId,
    String? sensorType,
    NodeStatus? status,
    String? gatewayId,
    String? locationId,
    NodeType? type,
    List<NodeEntity>? nodes,
  }) {
    return NodeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      sensorId: sensorId ?? this.sensorId,
      sensorType: sensorType ?? this.sensorType,
      status: status ?? this.status,
      gatewayId: gatewayId ?? this.gatewayId,
      locationId: locationId ?? this.locationId,
      type: type ?? this.type,
      nodes: nodes ?? this.nodes,
    );
  }
}
