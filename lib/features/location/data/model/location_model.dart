import '../../../../utils/constants/constants.dart';

class LocationModel {
  LocationModel({required this.id, required this.name, this.parentId});

  final String id;
  final String name;
  final String? parentId;

  LocationModel copyWith({String? id, String? name, String? parentId}) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() => {kId: id, kName: name, kParentId: parentId};

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map[kId],
      name: map[kName],
      parentId: map[kParentId],
    );
  }

  @override
  String toString() =>
      'LocationModel(id: $id, name: $name, parentId: $parentId)';

  @override
  bool operator ==(covariant LocationModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.parentId == parentId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ parentId.hashCode;
}
