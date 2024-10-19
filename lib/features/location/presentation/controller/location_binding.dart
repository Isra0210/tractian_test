import 'package:get/get.dart';

import '../../../../core/client/api_client.dart';
import '../../data/datasource/location_datasource.dart';
import '../../data/repositories/location_repository_impl.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/usecases/get_locations.dart';
import 'location_controller.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationDatasource>(
      () => LocationDatasourceImpl(client: Get.find<ApiClient>()),
    );
    Get.lazyPut<LocationRepository>(
      () => LocationRepositoryImpl(datasource: Get.find<LocationDatasource>()),
    );
    Get.lazyPut<GetLocations>(
      () => GetLocations(Get.find<LocationRepository>()),
    );
    Get.lazyPut<LocationController>(
      () => LocationController(getLocations: Get.find<GetLocations>()),
    );
  }
}
