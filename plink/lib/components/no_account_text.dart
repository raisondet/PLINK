import 'package:flutter/material.dart';
import 'package:plink/screens/sign_up/sign_up_screen.dart';

import '../constants.dart';
import '../size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "계정이 없으신가요?", //"Don’t have an account? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(14)),
        ),
        SizedBox(width:getProportionateScreenWidth(5)),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "회원 가입", //""Sign Up",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(14),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
