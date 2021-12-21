import 'package:flutter/material.dart';
import 'package:plink/constants.dart';
import 'package:plink/screens/sign_in/components/body.dart';
//import 'package:easy_localization/easy_localization.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "로그인",//""Sign In",
          style: TextStyle(
            color: kTextColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Body(),
    );
  }
}
