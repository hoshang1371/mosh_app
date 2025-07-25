

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
//! moshkel ine
// import 'package:cool_alert/cool_alert.dart';
import 'package:quickalert/quickalert.dart';

import 'package:moshfeghi/Data/user_data.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
// import 'dart:convert' as converter;

import 'package:connectivity_plus/connectivity_plus.dart';

import 'dart:async';

// import 'package:moshfeghi_app/Data/user_data.dart';
import 'package:moshfeghi/json_user.dart';
import 'package:moshfeghi/shared_preferences/shared_preferences_token.dart';


String tok = "";
// const String uriImportant = "http://localhost:8000";
// const String uriImportant = "http://127.0.0.1:8000";
const String uriImportant = "http://192.168.1.52:8000";
// http://127.0.0.1:8000/


class Network {
  static Uri url = Uri.parse("$uriImportant/api/api_token_auth/");
  static Uri urlGetProductList = Uri.parse("$uriImportant/api/");
  static Uri urlGetProductDitail = Uri.parse("$uriImportant/api");
  //static Uri urlGetProductList = Uri.parse("$uriImportant/api/");
  static Uri urlToken = Uri.parse("$uriImportant/api/Check_token/");
  static Uri urlProductData =
      Uri.parse("$uriImportant/api/product_order_staff/");
  //static String? tok;
  //! Check Internet

  static bool isConnected = false;

  static final Connectivity _connectivity = Connectivity();

    static Future<void> checkInternet(BuildContext context) async {
    // late ConnectivityResult result;
    late List<ConnectivityResult> result;
    // result = (await _connectivity.checkConnectivity()) as ConnectivityResult;
    result = await _connectivity.checkConnectivity();
    Connectivity().onConnectivityChanged.listen((status) {
    //  debugPrint("gdfgf");
    //  debugPrint(status.toString());
    //  debugPrint(result.contains(ConnectivityResult.wifi).toString());
    //  debugPrint(result.contains(ConnectivityResult.ethernet).toString());
      if (result.contains(ConnectivityResult.wifi) ||
          status.contains(ConnectivityResult.mobile)) {
        debugPrint("wifi");
        isConnected = true;
      } else {
        showInternetError(context);
        isConnected = false;
      }
    });

    return updateConnectionStatus(context, result[0]);
  }

    static Future<void> updateConnectionStatus(
      BuildContext context, ConnectivityResult result) async {
    // setState(() {
    //_connectionStatus = result;
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      isConnected = true;
    } else {
      showInternetError(context);
      isConnected = false;
    }
    // });
  }

  //! Show Error Internet
  static void showInternetError(BuildContext context) {

    // CoolAlert.show(
    //   width: 100,
    //   context: context,
    //   type: CoolAlertType.error,
    //   title: "خطا",
    //   confirmBtnText: "باشه",
    //   confirmBtnTextStyle: const TextStyle(
    //     fontSize: 16,
    //     color: Colors.white,
    //   ),
    //   confirmBtnColor: Colors.redAccent,
    //   text: 'شما به اینترنت متصل نیستید',
    // );

    QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'خطا',
        text: 'شما به اینترنت متصل نیستید',
        backgroundColor: Colors.black,
        titleColor: Colors.redAccent,
        textColor: Colors.white,
        confirmBtnText: 'باشه',
    );
  }

  

  //! post login data and get Token
  static void postDataLogin({
    required String? email,
    required String? password,
    required BuildContext context
  }) async {
    User user = User(email: email, password: password);
    var response = await http.post(Network.url, body: user.toJson());

    debugPrint("response.body");
    debugPrint(response.body);

    //response.body.contains('token');
    debugPrint("string is ${response.body.contains('token').toString()}");
    if (response.body.contains('token')) {
      addTokenStringToSF(response.body);
      var x = await getTokenStringValuesSF();
      debugPrint("Token Is $x");
    } else {
      // ! TODO: show alert
        QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'خطا',
        text: ' مشکلی بوجود امده است. ',
        backgroundColor: Colors.black,
        titleColor: Colors.redAccent,
        textColor: Colors.white,
        confirmBtnText: 'باشه',
        );
      debugPrint("Token is false");
    }
  }

  //! Show Error Response Internet
  static void showInternetResponseError(BuildContext context) {
    // CoolAlert.show(
    //   width: 100,
    //   context: context,
    //   type: CoolAlertType.error,
    //   title: "خطا",
    //   confirmBtnText: "باشه",
    //   confirmBtnTextStyle: const TextStyle(
    //     fontSize: 16,
    //     color: Colors.white,
    //   ),
    //   confirmBtnColor: Colors.redAccent,
    //   text: ' پاسخی از سرور دریافت نشد ',
    // );

        QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'خطا',
        text: ' پاسخی از سرور دریافت نشد ',
        backgroundColor: Colors.black,
        titleColor: Colors.redAccent,
        textColor: Colors.white,
        confirmBtnText: 'باشه',
        );
  }
  //! check token
  static postDataToken(
    String token,
    BuildContext context,
  ) async {
    Map valueMap = jsonDecode(token);
    var response = await http.post(Network.urlToken, body: {
      "token": "${valueMap["token"]}"
    }, headers: {
      "Authorization": "Token ${valueMap["token"]}",
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      debugPrint("err");
      showInternetResponseError(context);
      return http.Response('Error', 500);
    });

    if (response.statusCode == 200) {
      debugPrint("*****************************");
      debugPrint(response.body);
      Map valueMap = jsonDecode(response.body);
      UserData.username = valueMap["username"].toString();
      UserData.userid = valueMap["userid"].toString();
      debugPrint(valueMap["username"].toString());
      debugPrint(valueMap["userid"].toString());
      debugPrint(response.body.contains('"token":').toString());
      debugPrint(response.statusCode.toString());
      return (response.body);
      // if (response.body.contains('"token":')) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const LoginPage()),
      //   );
      // }
    } else {
      throw Exception('Album loading failed!');
    }
    // if (response.statusCode == 200) {
    //   debugPrint("ok 200");
    // } else {
    //   //debugPrint("err");
    //   throw Exception('Failed to load album');
    // }
  }
}
