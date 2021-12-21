import 'package:flutter/material.dart';
import 'package:plink/constants.dart';
import 'package:plink/screens/sign_in/components/body.dart';
import 'package:easy_localization/easy_localization.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ko', 'KR')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Sign In",
            style: TextStyle(
              color: kTextColor,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Body(),
      ),
    );
  }
}
