import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:yxt_building_fortification/pages/main_page.dart';

class App extends StatefulWidget{
  const App({super.key});


  @override
  State<App> createState()=>_AppState();
}

class _AppState extends State<App>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "易迅通筑垒工程",
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: const MainPage(),
    );
  }
}