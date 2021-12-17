import 'package:flutter/material.dart';
import 'package:plink/screens/home/components/section_title.dart';
import 'package:plink/size_config.dart';

import '../../../constants.dart';

class RecommendActivities extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Recommend",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              FeaturePlantCard(
                image: "assets/images/bottom_img_1.png",
                press: () {},
              ),
              FeaturePlantCard(
                image: "assets/images/bottom_img_2.png",
                press: () {},
              ),
            ],
          ),
        ),
      ]
    );
  }
}

class FeaturePlantCard extends StatelessWidget {
  const FeaturePlantCard({
    required this.image,
    required this.press,
  });
  final String image;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
