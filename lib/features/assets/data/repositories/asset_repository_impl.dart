import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:tractian/core/errors/errors.dart';
import '../../domain/repositories/asset_repository.dart';
import '../datasource/asset_datasourse.dart';
import '../datasource/asset_local_datasource.dart';

class AssetRepositoryImpl implements AssetRepository {
  AssetRepositoryImpl({
    required this.datasource,
    required this.localDatasource,
  });

  final AssetDatasource datasource;
  final AssetLocalDatasource localDatasource;

  final log = Logger('[AssetRepositoryImpl]');

  @override
  Future<Either<Failure, String>> getAssets(String companyId) async {
    try {
      // final assetsFromCache = localDatasource.getAssets();

      final assets = await datasource.getAssets(companyId);

      //   if (assetsFromCache.isEmpty) {
      //     // await localDatasource.saveAssets(assets);
      //     // return Right(assets);
      //   }
      //   log.info('Get ${assets.length} assets from api');
      return Right(assets);
    } on Failure {
      log.severe('Error when get Assets');
      return Left(GetAssetsFailure());
    } catch (e) {
      log.severe('$e');
      return Left(
        UnknownError(errorMessage: '$e', stackTrace: StackTrace.current),
      );
    }
  }
}
