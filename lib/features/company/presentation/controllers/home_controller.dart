import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:tractian/features/company/domain/entities/company_entity.dart';
import 'package:tractian/features/company/domain/usecases/get_companies.dart';

class HomeController extends GetxController implements GetxService {
  HomeController({required this.getCompanies});

  final log = Logger('[HomeController]');
  final GetCompanies getCompanies;

  final RxList<CompanyEntity> _companies = <CompanyEntity>[].obs;
  List<CompanyEntity> get companies => _companies;
  set companies(List<CompanyEntity> value) => _companies.value = value;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;
  set errorMessage(String value) => _errorMessage.value = value;

  Future<void> fetchCompany() async {
    isLoading = true;
    final failureOrCompany = await getCompanies();
    failureOrCompany.fold(
      (failure) {
        log.severe(failure.errorMessage);
        errorMessage = failure.errorMessage;
      },
      (companiesData) => companies = companiesData,
    );
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    fetchCompany();
    super.onInit();
  }
}
