import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../client/api_client.dart';
import '../client/api_client_dio.dart';

class DiSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<Dio>(Dio());
    Get.put<ApiClient>(ApiClientDio(Get.find<Dio>()));
    Get.put<GetStorage>(GetStorage());
  }
}
