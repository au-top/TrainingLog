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
  void initState() {
    super.initState();
    Sharedpreferences.createDB();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            vertical: 8,
          ),
        ),
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
  late bool autoLogin = false;
  late bool savePasswd = false;
  late TextEditingController username = TextEditingController(text: "");
  late TextEditingController passwd = TextEditingController(text: "");
  late ValueNotifier<bool> role = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                child: Text(
                  "注册",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 18),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      "登录页面",
                      style: Theme.of(context).textTheme.headline4!.copyWith(color: Theme.of(context).colorScheme.primary),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: Text(
                    "用户名",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black.withOpacity(0.5)),
                  ),
                  subtitle: TextField(
                    controller: username,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: Text("密码", style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black.withOpacity(0.5))),
                  subtitle: TextField(
                    controller: passwd,
                  ),
                ),
                Row(
                  children: [
                    const Text(
                      "管理员",
                    ),
                    StatefulBuilder(builder: (bc, ns) {
                      return Switch(
                        value: role.value,
                        onChanged: (v) {
                          handleOnSwitchRole(v);
                          ns(() => null);
                        },
                      );
                    }),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                Row(
                  children: [
                    const Text("自动登录"),
                    Checkbox(value: autoLogin, onChanged: handleOnTapAutoLogin),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    const Text("保存密码"),
                    Checkbox(value: savePasswd, onChanged: handleOnTapSvaePasswd),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: handleOnTapLogin,
                    child: const Text(
                      "登录",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          )
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .08,
      ),
    );
  }

  void handleOnSwitchRole(bool v) {
    role.value = v;
  }

  void handleOnTapSignUp() async {}

  void handleOnTapLogin() async {
    final result = await Sharedpreferences.testUser(username.text, passwd.text, role.value ? 1 : 0);
    if (result) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text("Success"),
            ),
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: const Text("失败"),
              color: Colors.white,
            ),
          );
        },
      );
    }
  }

  void handleOnTapAutoLogin(v) {
    setState(() {
      autoLogin = !autoLogin;
    });
  }

  void handleOnTapSvaePasswd(v) {
    setState(() {
      savePasswd = !savePasswd;
    });
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late final username = TextEditingController();
  late final passwd = TextEditingController();
  late final role = ValueNotifier(false);

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTileTheme(
      child: Scaffold(
        body: Padding(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "注册账号",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    subtitle: TextField(
                      controller: username,
                    ),
                    title: const Text("UserName"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    subtitle: TextField(
                      controller: passwd,
                    ),
                    title: const Text("Passwd"),
                  ),
                  StatefulBuilder(builder: (context, ns) {
                    return Row(
                      children: [
                        const Text("管理员"),
                        Switch(
                          value: role.value,
                          onChanged: (v) {
                            role.value = v;
                            ns(() => null);
                          },
                        )
                      ],
                    );
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () async {
                        final data = await Sharedpreferences.insertUser(username.text, passwd.text, role.value ? 1 : 0);
                        if (data) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                child: const Text("成功"),
                                padding: const EdgeInsets.all(10),
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                child: const Text("失败"),
                                padding: const EdgeInsets.all(10),
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        "登录",
                      ),
                    ),
                    width: double.infinity,
                  ),
                ],
              ),
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
        ),
      ),
      dense: true,
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
