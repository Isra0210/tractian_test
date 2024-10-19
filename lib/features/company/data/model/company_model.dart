import 'package:tractian/features/company/domain/entities/company_entity.dart';

import '../../../../utils/constants/constants.dart';

class CompanyModel extends CompanyEntity {
  CompanyModel({required super.id, required super.name});

  CompanyModel copyWith({String? id, String? name}) {
    return CompanyModel(id: id ?? this.id, name: name ?? this.name);
  }

  Map<String, dynamic> toMap() => {kId: id, kName: name};

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(id: map[kId], name: map[kName]);
  }

  @override
  String toString() => 'CompanyModel($kId: $id, $kName: $name)';

  @override
  bool operator ==(covariant CompanyModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
