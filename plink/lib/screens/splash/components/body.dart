import 'package:flutter/material.dart';
import 'package:plink/constants.dart';
import 'package:plink/components/default_button.dart';
import 'package:plink/screens/home/home_screen.dart';
import 'package:plink/screens/sign_in/sign_in_screen.dart';
import 'package:plink/screens/complete_profile/complete_profile_screen.dart';
import 'package:plink/size_config.dart';
import 'splash_content.dart';
import 'package:easy_localization/easy_localization.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;

  // TODO: make copyright
  List<Map<String, String>> splashData = [
    {
      "text": 'splash1_desc'.tr(),
      "image": "assets/images/splash_1.png"
    },
    {
      "text": 'splash2_desc'.tr(),
      "image": "assets/images/splash_2.png"
    },
    {
      "text": 'splash3_desc'.tr(),
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                            (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex:2),
                    DefaultButton(
                      text: "start".tr(),
                      press: () {
                        Navigator.pushNamed(context, SignInScreen.routeName);
                        //Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                        //Navigator.pushNamed(context, HomeScreen.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
