import 'dart:convert';

import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:tractian/features/assets/domain/entities/tree_node_entity.dart';

import 'package:tractian/features/assets/domain/usecases/get_assets.dart';
import 'package:tractian/features/location/data/model/location_model.dart';
import 'package:tractian/utils/constants/constants.dart';

import '../../../location/presentation/controller/location_controller.dart';
import '../../data/model/asset_model.dart';

class AssetController extends GetxController implements GetxService {
  AssetController({required this.getAssets});

  GetAssets getAssets;
  final location = Get.find<LocationController>();

  final log = Logger('[AssetController]');

  final Rx<NodeStatus> _filter = NodeStatus.none.obs;
  NodeStatus get filter => _filter.value;
  set filter(NodeStatus value) => _filter.value = value;

  final RxString _search = ''.obs;
  String get search => _search.value;
  set search(String value) => _search.value = value;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;
  set errorMessage(String value) => _errorMessage.value = value;

  final RxList<NodeEntity> _tree = <NodeEntity>[].obs;
  List<NodeEntity> get tree => _tree;
  set treeData(List<NodeEntity> value) => _tree.value = value;

  List<AssetModel> assets = [];

  List<T> parseData<T>(
      String body, T Function(Map<String, dynamic>) onConvert) {
    final parsed = (jsonDecode(body) as List).cast<Map<String, dynamic>>();

    return parsed.map<T>(onConvert).toList();
  }

  NodeStatus _convertStringToStatus(String status) => switch (status) {
        kAlert => NodeStatus.alert,
        kOperating => NodeStatus.operating,
        _ => NodeStatus.none,
      };

  bool nodeContainsName(NodeEntity node, String name) {
    return node.name.toLowerCase().contains(name.toLowerCase());
  }

  List<NodeEntity> buildTree(
    List<LocationModel> locations,
    List<AssetModel> assets,
  ) {
    List<NodeEntity> items = [];

    // Create nodes for all locations that don't have a parentId
    for (var location in locations) {
      if (location.parentId == null) {
        items.add(
          NodeEntity(
            id: location.id,
            name: location.name,
            type: NodeType.location,
            nodes: [],
          ),
        );
      }
    }

    // Add sub-locations to your parent locations
    for (var location in locations) {
      final parentLocation =
          items.firstWhereOrNull((i) => i.id == location.parentId);
      if (parentLocation != null) {
        parentLocation.nodes.add(
          NodeEntity(
            id: location.id,
            name: location.name,
            type: NodeType.subLocation,
            nodes: [],
          ),
        );
      }
    }

    //Add assets and components to the tree
    for (var asset in assets) {
      final node = NodeEntity(
        id: asset.id,
        name: asset.name,
        type: asset.sensorType != null ? NodeType.component : NodeType.asset,
        gatewayId: asset.gatewayId,
        locationId: asset.locationId,
        nodes: [],
        parentId: asset.parentId,
        sensorId: asset.sensorId,
        sensorType: asset.sensorType,
        status: _convertStringToStatus(asset.status ?? ''),
      );

      // Active unlinked: without parentId and locationId -> add to root
      if (asset.parentId == null && asset.locationId == null) {
        items.add(node);
      }
      // Active with locationId -> associates with the correct location
      else if (asset.locationId != null) {
        for (var item in items) {
          addNodeRecursively(item, node, locationId: asset.locationId);
        }
      }
      // Asset with parentId -> associates with parent asset
      else if (asset.parentId != null) {
        for (var item in items) {
          addNodeRecursively(item, node, parentId: asset.parentId);
        }
      }
    }
    // Add assets if missing
    for (var asset in assets) {
      final node = NodeEntity(
        id: asset.id,
        name: asset.name,
        type: asset.sensorType != null ? NodeType.component : NodeType.asset,
        gatewayId: asset.gatewayId,
        locationId: asset.locationId,
        nodes: [],
        parentId: asset.parentId,
        sensorId: asset.sensorId,
        sensorType: asset.sensorType,
        status: _convertStringToStatus(asset.status ?? ''),
      );
      for (var item in items) {
        addNodeRecursively(
          item,
          node,
          parentId: asset.parentId,
          locationId: asset.locationId,
        );
      }
    }
    return items;
  }

  void addNodeRecursively(
    NodeEntity parent,
    NodeEntity node, {
    String? locationId,
    String? parentId,
  }) {
    bool nodeExists = parent.nodes.any((child) => child.id == node.id);

    if (!nodeExists) {
      if ((locationId != null && parent.id == locationId) ||
          (parentId != null && parent.id == parentId)) {
        parent.nodes.add(node);
      } else {
        for (var child in parent.nodes) {
          addNodeRecursively(child, node,
              locationId: locationId, parentId: parentId);
        }
      }
    }
  }

  Future<void> fetchAssets(String companyId) async {
    isLoading = true;
    final failureOrAssets = await getAssets(companyId);
    final failureOrLocations = await location.getLocations(companyId);
    failureOrAssets.fold(
      (failure) {
        log.severe(failure.errorMessage);
        errorMessage = failure.errorMessage;
      },
      (assetsData) => assets = parseData<AssetModel>(
        assetsData,
        (json) => AssetModel.fromMap(json),
      ),
    );
    failureOrLocations.fold(
      (failure) {
        log.severe(failure.errorMessage);
        errorMessage = failure.errorMessage;
      },
      (locationsData) => location.locations = parseData<LocationModel>(
        locationsData,
        (json) => LocationModel.fromMap(json),
      ),
    );
    _tree.value = buildTree(location.locations, assets);
    isLoading = false;
    update();
  }
}
