import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plink/constants.dart';
import 'package:plink/size_config.dart';
//import 'package:easy_localization/easy_localization.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": "assets/icons/Flash Icon.svg", "text": "골프"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "테니스"},
      {"icon": "assets/icons/Game Icon.svg", "text": "피트니스"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "자전거"},
      {"icon": "assets/icons/Flash Icon.svg", "text": "맛집투어"},
      {"icon": "assets/icons/Bill Icon.svg", "text": "수다떨기"},
      {"icon": "assets/icons/Game Icon.svg", "text": "치맥하기"},
      {"icon": "assets/icons/Gift Icon.svg", "text": "노래방"},
      {"icon": "assets/icons/Discover.svg", "text": "스터디"},
    ];
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(getProportionateScreenWidth(15)),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                categories.length,
                    (index) => CategoryCard(
                  icon: categories[index]["icon"],
                  text: categories[index]["text"],
                  press: () {},
                ),
              ),
            ),
          ),
        ),
        //Divider(),
      ]
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(65),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              margin: EdgeInsets.all(getProportionateScreenWidth(5)),
              height: getProportionateScreenWidth(50),
              width: getProportionateScreenWidth(50),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: SvgPicture.asset(icon!, color: Colors.white,),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  /*
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      _button("Popular", Icons.favorite, Colors.blue),
      _button("Food", Icons.restaurant, Colors.red),
      _button("Events", Icons.event, Colors.amber),
      _button("More", Icons.more_horiz, Colors.green),
    ],
  ),
  SizedBox(
    height: 36.0,
  ),

  Widget _button(String label, IconData icon, Color color) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            color: Colors.white,
          ),
          decoration:
          BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 8.0,
            )
          ]),
        ),
        SizedBox(
          height: 12.0,
        ),
        Text(label),
      ],
    );
  }
  */

}
