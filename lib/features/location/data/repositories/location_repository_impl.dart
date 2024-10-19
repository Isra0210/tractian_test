import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:tractian/core/errors/errors.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasource/location_datasource.dart';

class LocationRepositoryImpl implements LocationRepository {
  LocationRepositoryImpl({required this.datasource});

  final LocationDatasource datasource;

  final log = Logger('[LocationRepositoryImpl]');

  @override
  Future<Either<Failure, String>> getLocations(String companyId) async {
    try {
      final locations = await datasource.getLocations(companyId);
      log.info('Get ${locations.length} locations from api');
      return Right(locations);
    } on Failure {
      log.severe('Error when get locations');
      return Left(GetLocationsFailure());
    } catch (e) {
      log.severe('$e');
      return Left(
        UnknownError(errorMessage: '$e', stackTrace: StackTrace.current),
      );
    }
  }
}
