import 'package:flutter/material.dart';

import 'package:plink/size_config.dart';
import 'package:plink/screens/home/components/section_title.dart';

class SpecialOffers extends StatelessWidget {
  List<Map<String, dynamic>> specials = [
    {
      "image": "assets/images/Image Banner 2.png",
      "category": "Smartphone",
      "numOfBrands": 18
    },
    {
      "image": "assets/images/Image Banner 3.png",
      "category": "Fashion",
      "numOfBrands": 24
    },
    {
      "image": "assets/images/Image Banner 2.png",
      "category": "Smartphone",
      "numOfBrands": 18
    },
  ];

  /* const SpecialOffers({
    Key? key,
  }) : super(key: key);
*/
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SectionTitle(
            title: "Special for you",
            press: () {},
          ),
        ),
        SizedBox(height: getProportionateScreenWidth(20)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(specials.length,
                  (index) =>
                  SpecialOfferCard(
                    image: specials[index]["image"],
                    category: specials[index]["category"],
                    numOfBrands: specials[index]["numOfBrands"],
                    press: () {},
                  ),
            ),
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Padding(
      padding: EdgeInsets.only(left: getProportionateScreenWidth(20)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: size.width * 0.6,
          height: getProportionateScreenWidth(90),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(15.0),
                    vertical: getProportionateScreenWidth(10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: getProportionateScreenWidth(18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
