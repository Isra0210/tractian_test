import 'dart:io';

import 'package:logging/logging.dart';
import 'dart:async';
import 'dart:developer';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

import '../constants/constants.dart';

class LogUtils {
  static get date => DateTime.now();

  static String _fileName(String prefixPath, String extension) {
    return '${prefixPath}_${date.year}-${date.month}-${date.day}.$extension';
  }

  static Future<File> getFile({
    String filePrefix = kApp,
    String folderName = kAppLogs,
    String extension = kExtension,
  }) async {
    final documentsDir = await path_provider.getApplicationDocumentsDirectory();
    final logsDir = Directory(path.join(documentsDir.path, folderName));
    if (!logsDir.existsSync()) logsDir.createSync();
    final filePath = path.join(logsDir.path, _fileName(filePrefix, extension));
    return File(filePath);
  }

  static void init() async {
    final logFile = await getFile();
    String logLevelString = const String.fromEnvironment('LOG_LEVEL');
    Level.LEVELS.firstWhere(
      (level) => level.name.toLowerCase() == logLevelString.toLowerCase(),
      orElse: () => Level.SEVERE,
    );
    Logger.root.onRecord.listen((record) {
      final regex = RegExp(r'\d{2}:\d{2}:\d{2}.\d{6}');
      final time = regex.firstMatch(record.time.toString())?.group(0);
      final line = '${padLevelName(record.level)}: $time: ${record.message}\n';
      log(line);
      logFile.writeAsStringSync(line, mode: FileMode.append);
    });
  }

  static String padLevelName(Level level) {
    switch (level.name) {
      case 'OFF':
        return '    OFF';
      case 'SHOUT':
        return '  SHOUT';
      case 'SEVERE':
        return ' SEVERE';
      case 'WARNING':
        return 'WARNING';
      case 'INFO':
        return '   INFO';
      case 'CONFIG':
        return ' CONFIG';
      case 'FINE':
        return '   FINE';
      case 'FINER':
        return '  FINER';
      case 'FINEST':
        return ' FINEST';
      default:
        return level.name;
    }
  }
}
