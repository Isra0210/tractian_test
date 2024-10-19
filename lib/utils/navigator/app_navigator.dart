import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppNavigator {
  AppNavigator.of(this.context);

  final BuildContext context;

  Future<T?> to<T>(
    Widget page, {
    Object? arguments,
    Transition? transition,
    Curve? curve,
    bool fullscreenDialog = false,
  }) async {
    return await Get.to(
      () => page,
      arguments: arguments,
      transition: transition,
      curve: curve,
      fullscreenDialog: fullscreenDialog,
    );
  }

  Future<T?>? toNamed<T>(
    String route, {
    Map<String, String>? parameters,
    Object? arguments,
  }) {
    return Get.toNamed<T?>(route, arguments: arguments, parameters: parameters);
  }

  Future<T?>? offNamed<T>(
    String route, {
    Map<String, String>? parameters,
    Object? arguments,
  }) =>
      Get.offNamed<T?>(route, arguments: arguments, parameters: parameters);

  Future<T?>? offAllNamed<T>(String route,
          {Map<String, String>? parameters, Object? arguments, W}) =>
      Get.offAllNamed(route, arguments: arguments, parameters: parameters);

  void pop<T extends Object?>([T? result]) => Navigator.of(context).pop();
}
