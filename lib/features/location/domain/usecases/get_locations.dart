import 'package:dartz/dartz.dart';
import 'package:tractian/core/errors/errors.dart';

import '../repositories/location_repository.dart';

class GetLocations {
  final LocationRepository repository;

  GetLocations(this.repository);

  Future<Either<Failure, String>> call(String companyId) {
    return repository.getLocations(companyId);
  }
}
