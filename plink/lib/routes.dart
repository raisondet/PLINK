import 'package:flutter/widgets.dart';
import 'package:plink/screens/chatting/chat_screen.dart';
// import 'package:shop_app/screens/cart/cart_screen.dart';
import 'package:plink/screens/complete_profile/complete_profile_screen.dart';
// import 'package:shop_app/screens/details/details_screen.dart';
import 'package:plink/screens/forgot_password/forgot_password_screen.dart';
import 'package:plink/screens/home/home_screen.dart';
import 'package:plink/screens/login_success/login_success_screen.dart';
import 'package:plink/screens/otp/otp_screen.dart';
import 'package:plink/screens/profile/profile_screen.dart';
import 'package:plink/screens/sign_in/sign_in_screen.dart';
import 'package:plink/screens/sign_up/sign_up_screen.dart';
import 'package:plink/screens/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  ChatScreen.routeName: (context) => ChatScreen(),

  /*
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  */
};
