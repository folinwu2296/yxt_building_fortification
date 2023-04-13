import 'dart:ui';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> with WindowListener {
  int _loginType = 1;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    windowManager.addListener(this);
    _init();
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  void _init() async {
    await windowManager.setPreventClose(true);
    setState(() {});
  }

  @override
  void onWindowClose() async {
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Are you sure you want to close this window?'),
              actions: [
                TextButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Yes'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    await windowManager.destroy();
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg_login.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              // color: Colors.amber,
            ),
            Expanded(
              child: Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0x1AFFFFFF),
                        borderRadius: BorderRadius.circular(4)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                            sigmaX: 6, sigmaY: 6, tileMode: TileMode.mirror),
                        child: Container(
                          margin: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _tabText("账号密码登录", 1, () {
                                    if (_loginType == 1) {
                                      return;
                                    }
                                    _userNameController.clear();
                                    _passwordController.clear();
                                    setState(() {
                                      _loginType = 1;
                                    });
                                  }),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  _tabText("手机号登录", 2, () {
                                    if (_loginType == 2) {
                                      return;
                                    }
                                    _userNameController.clear();
                                    _passwordController.clear();
                                    setState(() {
                                      _loginType = 2;
                                    });
                                  })
                                ],
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 312,
                                height: 44,
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0x4DFFFFFF),
                                        width: 1)),
                                child: TextField(
                                  controller: _userNameController,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          _loginType == 1 ? "请输入账号" : "请输入手机号码",
                                      hintStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0x4DFFFFFF)),
                                      counterText: ""),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  maxLength: 20,
                                  cursorColor: Color(0xFF2EC0FF),
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                width: 312,
                                height: 44,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0x4DFFFFFF),
                                        width: 1)),
                                child: TextField(
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "请输入密码",
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Color(0x4DFFFFFF)),
                                      counterText: ""),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  maxLength: 20,
                                  cursorColor: Color(0xFF2EC0FF),
                                ),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              InkWell(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 312,
                                  height: 44,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF2EC0FF),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: const Text(
                                    "登录",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                                onTap: () {
                                  if (_userNameController.value.text.isEmpty) {
                                    if (_loginType == 1) {
                                      BotToast.showText(text: "请输入账号");
                                    } else {
                                      BotToast.showText(text: "请输入手机号码");
                                    }
                                    return;
                                  }
                                  if (_passwordController.value.text.isEmpty) {
                                    BotToast.showText(text: "请输入密码");
                                    return;
                                  }
                                  BotToast.showText(text: "惊不惊喜，意不意外！");
                                },
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _bottomText("立即注册"),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  _bottomText("忘记密码"),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  _bottomText("APP下载"),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  _bottomText("关注小程序"),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              // color: Colors.redAccent,
            )
          ],
        ),
      ),
    );
  }

  Widget _tabText(String text, int loginType, VoidCallback callback) {
    Color textColor =
        _loginType == loginType ? Colors.white : const Color(0xB3FFFFFF);
    return InkWell(
      onTap: callback,
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w400, fontSize: 14, color: textColor),
      ),
    );
  }

  Widget _bottomText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xB3FFFFFF)),
    );
  }
}
