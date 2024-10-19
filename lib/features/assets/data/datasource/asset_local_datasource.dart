import 'package:get_storage/get_storage.dart';

import '../model/asset_model.dart';

const kAssetsCached = 'locationsCached';

abstract class AssetLocalDatasource {
  Future<void> saveAssets(List<AssetModel> assets);
  List<AssetModel> getAssets();
}

class AssetLocalDatasourceImpl implements AssetLocalDatasource {
  AssetLocalDatasourceImpl({required this.storage});

  final GetStorage storage;

  @override
  Future<void> saveAssets(List<AssetModel> assets) async {
    final assetsAsMap = assets.map((asset) => asset.toMap()).toList();
    await storage.write(kAssetsCached, assetsAsMap);
  }

  @override
  List<AssetModel> getAssets() {
    final assetsAsMap = storage.read(kAssetsCached);
    if (assetsAsMap != null) {
      final assets =
          (assetsAsMap as List).map((e) => AssetModel.fromMap(e)).toList();
      return assets;
    }
    return [];
  }
}
