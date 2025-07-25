import 'package:flutter/material.dart';


// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:moshfeghi/Screens/login_page.dart';


import 'package:loader_overlay/loader_overlay.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const LoaderOverlay(
        overlayColor: Colors.black,
        // overlayOpacity: 0.8,
        //child: MyHomePage(),
        child: LoginPage(),
        //child: QRViewExample(),
        //child: BasePage(),
      ),
    );
  }
}
