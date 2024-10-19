import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../repositories/asset_repository.dart';

class GetAssets {
  final AssetRepository repository;

  GetAssets(this.repository);

  Future<Either<Failure, String>> call(String companyId) => repository.getAssets(companyId);
}
