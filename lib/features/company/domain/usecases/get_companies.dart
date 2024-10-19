import 'package:dartz/dartz.dart';
import 'package:tractian/core/errors/errors.dart';
import 'package:tractian/features/company/domain/entities/company_entity.dart';
import '../repositories/company_repository.dart';

class GetCompanies {
  final CompanyRepository repository;

  GetCompanies(this.repository);

  Future<Either<Failure, List<CompanyEntity>>> call() {
    return repository.getCompanies();
  }
}
