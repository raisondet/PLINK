import 'package:flutter/material.dart';
import 'package:plink/components/coustom_bottom_nav_bar.dart';
import 'package:plink/enums.dart';
import 'package:plink/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}

