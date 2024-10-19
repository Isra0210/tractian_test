import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:tractian/features/location/data/model/location_model.dart';
import 'package:tractian/features/location/domain/usecases/get_locations.dart';

import '../../../../core/errors/errors.dart';

class LocationController extends GetxController implements GetxService {
  LocationController({required this.getLocations});

  final log = Logger('[LocationController]');
  final GetLocations getLocations;

  List<LocationModel> locations = [];

  List<LocationModel> parseLocations(String body) {
    final parsed = (jsonDecode(body) as List).cast<Map<String, dynamic>>();

    return parsed
        .map<LocationModel>((json) => LocationModel.fromMap(json))
        .toList();
  }

  Future<Either<Failure, String>> fetchLocations(String companyId) async {
    final failureOrCompany = await getLocations(companyId);

    return failureOrCompany;
  }
}
