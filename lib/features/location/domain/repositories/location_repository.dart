import 'package:dartz/dartz.dart';
import '../../../../core/errors/errors.dart';

abstract class LocationRepository {
  Future<Either<Failure, String>> getLocations(String companyId);
}
