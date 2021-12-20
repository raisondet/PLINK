import 'package:flutter/material.dart';
import 'package:plink/constants.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
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
