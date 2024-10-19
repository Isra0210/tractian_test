import 'package:get_storage/get_storage.dart';

import '../model/company_model.dart';

const kCompaniesCached = 'companiesCached';

abstract class CompanyLocalDatasource {
  Future<void> saveCompanies(List<CompanyModel> companies);
  List<CompanyModel> getCompanies();
}

class CompanyLocalDatasourceImpl implements CompanyLocalDatasource {
  CompanyLocalDatasourceImpl({required this.storage});

  final GetStorage storage;

  @override
  Future<void> saveCompanies(List<CompanyModel> companies) async {
    final companiesAsMap = companies.map((company) => company.toMap()).toList();
    await storage.write(kCompaniesCached, companiesAsMap);
  }

  @override
  List<CompanyModel> getCompanies() {
    final companiesStringList = storage.read(kCompaniesCached);
    if (companiesStringList != null) {
      final companies = (companiesStringList as List)
          .map((e) => CompanyModel.fromMap(e))
          .toList();
      return companies;
    }
    return [];
  }
}
