import 'package:dartz/dartz.dart';
import 'package:tractian/features/company/domain/entities/company_entity.dart';
import '../../../../core/errors/errors.dart';

abstract class CompanyRepository {
  Future<Either<Failure, List<CompanyEntity>>> getCompanies();
}
