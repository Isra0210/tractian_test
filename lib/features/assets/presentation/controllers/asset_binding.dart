import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tractian/features/assets/domain/usecases/get_assets.dart';

import '../../../../core/client/api_client.dart';
import '../../data/datasource/asset_datasourse.dart';
import '../../data/datasource/asset_local_datasource.dart';
import '../../data/repositories/asset_repository_impl.dart';
import '../../domain/repositories/asset_repository.dart';
import 'assets_controller.dart';

class AssetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetDatasource>(
      () => AssetDatasourceImpl(client: Get.find<ApiClient>()),
    );
    Get.lazyPut<AssetLocalDatasource>(
      () => AssetLocalDatasourceImpl(storage: Get.find<GetStorage>()),
    );
    Get.lazyPut<AssetRepository>(
      () => AssetRepositoryImpl(
        datasource: Get.find<AssetDatasource>(),
        localDatasource: Get.find<AssetLocalDatasource>(),
      ),
    );
    Get.lazyPut<GetAssets>(
      () => GetAssets(Get.find<AssetRepository>()),
    );
    Get.lazyPut<AssetController>(
      () => AssetController(getAssets: Get.find<GetAssets>()),
    );
  }
}
