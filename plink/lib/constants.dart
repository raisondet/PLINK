import 'package:flutter/material.dart';
import 'package:plink/size_config.dart';

const kPrimaryColor = Color(0xFF19C1CB);
const kPrimaryLightColor = Color(0xFFD1F3F5);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kToastBgColor = Color(0xFF737373);
const kBackgroundColor = Color(0xFFF9F8FD);

const double kDefaultPadding = 20.0;
const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter valid email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kUserNotFound = "사용자 정보를 확인할 수 없습니다. \n이메일을 다시 입력해 주세요."; //"User not found. \nPlease Enter your email!";
const String kWrongPassword = "비밀번호가 틀렸습니다. \n비밀번호를 다시 입력해주세요."; //"Password is wrong. \nPlease Enter your password!";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kDateBirthNullError = "Please Enter your date of birth";

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

const kMessageTextFieldDecoration =  InputDecoration.collapsed(
  hintText: 'Type Something...',
  hintStyle: TextStyle(color: Colors.blueGrey),
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);
