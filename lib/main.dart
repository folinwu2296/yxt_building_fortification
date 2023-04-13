import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:yxt_building_fortification/app.dart';
import 'package:yxt_building_fortification/utils/platform_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (PlatformUtils.isDeskTop) {
    _initWindows();
  }
  runApp(const App());
}

void _initWindows() async {
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions,()async{
    await windowManager.show();
    await windowManager.focus();
  });
}
