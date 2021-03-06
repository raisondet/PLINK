//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:plink/routes.dart';
import 'package:plink/screens/sign_in/sign_in_screen.dart';
import 'package:plink/theme.dart';
import 'package:plink/screens/splash/splash_screen.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      //home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute:  SplashScreen.routeName, //SignInScreen.routeName,
      routes: routes,
    );
  }
}
