import 'package:dartz/dartz.dart';
import 'package:logging/logging.dart';
import 'package:tractian/core/errors/errors.dart';
import 'package:tractian/features/company/domain/entities/company_entity.dart';
import '../../domain/repositories/company_repository.dart';
import '../datasource/company_datasource.dart';
import '../datasource/company_local_datasource.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  CompanyRepositoryImpl({
    required this.datasource,
    required this.localDatasource,
  });

  final CompanyDatasource datasource;
  final CompanyLocalDatasource localDatasource;

  final log = Logger('[CompanyRepositoryImpl]');

  @override
  Future<Either<Failure, List<CompanyEntity>>> getCompanies() async {
    try {
      final companiesFromCache = localDatasource.getCompanies();
      final companies = await datasource.getCompanies();
      if (companiesFromCache.isEmpty) {
        await localDatasource.saveCompanies(companies);
        return Right(companies);
      }
      log.info('Get ${companies.length} companies from api');
      return Right(companiesFromCache);
    } on Failure {
      log.severe('Error when get companies');
      return Left(GetCompaniesFailure());
    } catch (e) {
      log.severe('$e');
      return Left(
        UnknownError(errorMessage: '$e', stackTrace: StackTrace.current),
      );
    }
  }
}
