@JS()
library callable_function;

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS('jsOnEvent')
external set _jsOnEvent(void Function(dynamic event) f);

@JS()
external dynamic jsInvokeMethod(String method, String? params);

class NotificationPermissionsPluginWeb {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'notification_permissions',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = NotificationPermissionsPluginWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);

    //Sets the call from JavaScript handler
    _jsOnEvent = allowInterop((dynamic event) {
      //Process JavaScript call here
    });
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getNotificationPermissionStatus':
        return sendMethodMessage(call.method, call.arguments);
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              "notification_permissions for web doesn't implement '${call.method}'",
        );
    }
  }

  Future<dynamic> sendMethodMessage(String method, String? arguments) async {
    final dynamic response =
        await promiseToFuture(jsInvokeMethod(method, arguments));

    return response;
  }
}