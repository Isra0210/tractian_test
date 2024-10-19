import 'dart:convert';
import 'dart:isolate';

import 'package:tractian/core/client/api_client.dart';
import 'package:tractian/core/errors/errors.dart';

import '../../../../utils/constants/constants.dart';

abstract class LocationDatasource {
  Future<String> getLocations(String companyId);
}

class LocationDatasourceImpl implements LocationDatasource {
  final ApiClient client;

  LocationDatasourceImpl({required this.client});

  static void isolateFunction(SendPort sendPort) {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    port.listen((message) {
      final data = message[0] as String;
      final responsePort = message[1] as SendPort;
      responsePort.send(data);
    });
  }

  static Future<String> runInIsolate(String data) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(isolateFunction, receivePort.sendPort);

    final sendPort = await receivePort.first as SendPort;
    final resultPort = ReceivePort();

    sendPort.send([data, resultPort.sendPort]);

    return await resultPort.first;
  }

  @override
  Future<String> getLocations(String companyId) async {
    final response = await client.get('/$kCompanies/$companyId/$kLocations');

    if (response.statusCode == 200) {
      final result = await runInIsolate(jsonEncode(response.data));
      return result;
    } else {
      throw GetAssetsFailure();
    }
  }
}
