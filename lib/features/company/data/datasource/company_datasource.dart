import 'package:tractian/core/client/api_client.dart';
import 'package:tractian/core/errors/errors.dart';

import '../../../../utils/constants/constants.dart';
import '../model/company_model.dart';

abstract class CompanyDatasource {
  Future<List<CompanyModel>> getCompanies();
}

class CompanyDatasourceImpl implements CompanyDatasource {
  final ApiClient client;

  CompanyDatasourceImpl({required this.client});

  @override
  Future<List<CompanyModel>> getCompanies() async {
    final response = await client.get('/$kCompanies');

    if (response.statusCode == 200) {
      final companies = (response.data as List)
          .map((company) => CompanyModel.fromMap(company))
          .toList();
      return companies;
    } else {
      throw GetCompaniesFailure();
    }
  }
}
