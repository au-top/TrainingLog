import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sharedpreferences/sharedpreferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(isDense: true, contentPadding: EdgeInsets.only(top: 5)),
      ),
      home: ListTileTheme(
        child: Builder(
          builder: (context) {
            return const Scaffold(
              body: SafeArea(
                child: Login(),
              ),
            );
          },
        ),
        dense: true,
        contentPadding: const EdgeInsets.all(0),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late  bool autoLogin;
  late  bool savePasswd;

  @override
  void initState(){
    super.initState();
    autoLogin=false;
    savePasswd=false;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text(
              "User",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            subtitle: const TextField(),
          ),
          ListTile(
            title: Text("Passwd", style: Theme.of(context).textTheme.subtitle1),
            subtitle: const TextField(),
          ),
          Row(
            children: [
              const Text("自动登入"),
              Checkbox(value: autoLogin, onChanged: handleOnTapAutoLogin),
              const Expanded(
                child: SizedBox(),
              ),
              const Text("保存密码"),
              Checkbox(value: savePasswd, onChanged:handleOnTapSvaePasswd),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
          const Text(""),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("登入"),
            ),
          )
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .08,
      ),
    );
  }


  void handleOnTapAutoLogin(v){
    setState(() {
      autoLogin=!autoLogin;
    });
  }
  void handleOnTapSvaePasswd(v){
    setState(() {
      savePasswd=!savePasswd;
    });
  }
}
