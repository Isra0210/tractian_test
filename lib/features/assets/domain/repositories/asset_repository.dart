import 'package:dartz/dartz.dart';
import '../../../../core/errors/errors.dart';

abstract class AssetRepository {
  Future<Either<Failure, String>> getAssets(String companyId);
}
