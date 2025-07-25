import 'package:moshfeghi/Network/Network.dart';
import "package:flutter/material.dart";

import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:moshfeghi/json_user.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'dart:async';

import 'package:quickalert/quickalert.dart';


import 'base_page.dart';

import 'package:moshfeghi/shared_preferences/shared_preferences_token.dart';

// import 'dart:developer' as developer;
// import 'package:flutter/services.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

// String? tok;
late StreamSubscription<ConnectivityResult> _connectivitySubscription;

Future<String> getValue(BuildContext context) async {
  // !faal shavad
  // final network = Network();
  // String? bodyResponse;
  getTokenStringValuesSF().then((token) {
    debugPrint("hojjat");
    debugPrint("token $token");

    Network.checkInternet(context).then((value) {
      // debugPrint("gdfgf");
      if (Network.isConnected == true) {


        Network.postDataToken(token, context).then((val) {
          // debugPrint("val $val");
          tok = val;
          debugPrint("tok $tok");

          if (tok.contains('"token":')) {
              // !faal
              // Navigator.push(
              //   context,
              //   //MaterialPageRoute(builder: (context) => const ProductList()),
              //   MaterialPageRoute(builder: (context) => const BasePage()),
              // );
              //!


            // Network.getGetProductList(tok).then((value1) {
            //   debugPrint(products.length.toString());
            //   // TODO
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => const ProductList()),
            //   );
            // });
          }
        });
      }
    });
  });
  await Future.delayed(const Duration(seconds: 3), () {});

  return 'Flutter Devs';
}

// getData(BuildContext context) {
//   getTokenStringValuesSF().then((value) {
//     debugPrint(value);
//     tok = value;
//     debugPrint("tok");
//     debugPrint(tok);
//     Network.postDataToken(value,context);
//   });
//   // await Future.delayed(Duration(seconds: 3));
//   // return 'Flutter Devs';
// }

Future<String>? value;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // ConnectivityResult _connectionStatus = ConnectivityResult.none;
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    value = getValue(context);

    // Network.initConnectivity();

    // _connectivitySubscription =
        // _connectivity.onConnectivityChanged.listen(Network.updateConnectionStatus);
  }

  @override
  dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // final bool isKeyboardVisible =
    //     KeyboardVisibilityProvider.isKeyboardVisible(context);
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Color(0xFF151026),

        title: Text(
          "Moshfeghi",
          style: TextStyle(
            color: Color(0xFF999999),
            fontFamily: 'Gandom',
            ),
          // textAlign: TextAlign.center,
          ),
      ),
      body: FutureBuilder(
        future: value, 
        builder: (BuildContext context, AsyncSnapshot snapshot){
              if (snapshot.connectionState == ConnectionState.done) {
              // if (true) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      // (isKeyboardVisible)? Text(
                      //   'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}',
                      // ):
                      isKeyboardVisible
                          ? const SizedBox.shrink()
                          : const Text(
                              "سلام",
                              style: TextStyle(
                                fontFamily: 'Gandom',
                                fontSize: 52,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      isKeyboardVisible
                          ? const SizedBox.shrink()
                          : const Text(
                              'به نرم افزار مدیریت فروشگاه مشفقی خوش آمدید',
                              style: TextStyle(
                                fontFamily: 'Gandom',
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                      const SizedBox(
                        height: 50,
                      ),

                      //email text fild
                      UserTextFeild(
                        text: "ایمیل",
                        controller: emailController,
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      //password text fild
                      UserTextFeild(
                        text: "پسوورد",
                        controller: passwordController,
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //login
                      userLogin(),

                      const SizedBox(
                        height: 25,
                      ),

                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
        },
        )
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    ),
    );
    });
  }

  Padding userLogin() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      //ElevatedButton
      child: ElevatedButton(
        onPressed: () {
          //context.loaderOverlay.show();
          // Network.showInternetError(context);

// !faal
          final user = User(
            email: emailController.text,
            password: passwordController.text,
          );
          debugPrint(emailController.text);
          debugPrint(passwordController.text);
          // final json = user.toJson();
          // debugPrint("JSON: ${user.toJson()}");
          // final newUser = User.fromJson(json);
          // debugPrint('$newUser');
          // final network = Network();

          // network.postDataLogin(
          //   email: emailController.text,
          //   password: passwordController.text,
          // );
          // !faal
          Network.postDataLogin(
            email: user.email,
            password: user.password,
            context: context,
          );
          debugPrint("fdsfgdf");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Color(0xFFCE492B), //change background color of button
          foregroundColor: Color(0xFF467197), //change text color of button
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 15.0,
        ),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: const Center(
            child: Text(
              'ورود',
              style: TextStyle(
                fontFamily: 'Gandom',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ),
        ), //888
      ),
    );
  }
}

class UserTextFeild extends StatelessWidget {
  const UserTextFeild({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);

  final String text;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0),
          child: TextField(
            controller: controller,
            obscureText: (controller == passwordController) ? true : false,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: text,
              hintTextDirection: TextDirection.rtl,
              hintStyle: const TextStyle(
                fontFamily: 'Gandom',
              ),
            ),
          ),
        ),
      ),
    );
  }
}




/*

Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // (isKeyboardVisible)? Text(
                //   'The keyboard is: ${isKeyboardVisible ? 'VISIBLE' : 'NOT VISIBLE'}',
                // ):
                isKeyboardVisible
                    ? const SizedBox.shrink()
                    : const Text(
                        "سلام",
                        style: TextStyle(
                          fontFamily: 'Gandom',
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                isKeyboardVisible
                    ? const SizedBox.shrink()
                    : const Text(
                        'به نرم افزار مدیریت فروشگاه اسپاد خوش آمدید',
                        style: TextStyle(
                          fontFamily: 'Gandom',
                          fontSize: 20,
                        ),
                      ),
                const SizedBox(
                  height: 50,
                ),

                //email text fild
                UserTextFeild(
                  text: "ایمیل",
                  controller: emailController,
                ),

                const SizedBox(
                  height: 10,
                ),
                //password text fild
                UserTextFeild(
                  text: "پسوورد",
                  controller: passwordController,
                ),

                const SizedBox(
                  height: 25,
                ),

                //login
                userLogin(),

                const SizedBox(
                  height: 25,
                ),

              ],
            ),
          ),


*/ 
