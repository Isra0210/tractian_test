import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractian/features/company/domain/usecases/get_companies.dart';

import '../../../../core/client/api_client.dart';
import '../../data/datasource/company_datasource.dart';
import '../../data/datasource/company_local_datasource.dart';
import '../../data/repositories/company_repository_impl.dart';
import '../../domain/repositories/company_repository.dart';
import 'home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CompanyDatasource>(
      CompanyDatasourceImpl(client: Get.find<ApiClient>()),
    );
    Get.put<CompanyLocalDatasource>(
      CompanyLocalDatasourceImpl(storage: Get.find<GetStorage>()),
    );
    Get.put<CompanyRepository>(
      CompanyRepositoryImpl(
        datasource: Get.find<CompanyDatasource>(),
        localDatasource: Get.find<CompanyLocalDatasource>(),
      ),
    );
    Get.put<GetCompanies>(
      GetCompanies(Get.find<CompanyRepository>()),
    );
    Get.put<HomeController>(
      HomeController(getCompanies: Get.find<GetCompanies>()),
    );
  }
}
