import 'package:flutter/material.dart';
import 'package:plink/screens/home/components/section_title.dart';
import 'package:plink/size_config.dart';
//import 'package:plink/screens/details/details_screen.dart';

import 'package:plink/constants.dart';

class RealtimeActivities extends StatelessWidget {
  /*const RealtimeActivities({
    required Key? key,
  }) : super(key: key);*/

  List<Map<String, dynamic>> realtimeActivities = [
    {
      "image": "assets/images/image_1.png",
      "title": "2:2 Golf",
      "category": "Smartphone",
      "country": "gangnam",
      "price": 18
    },
    {
      "image": "assets/images/image_2.png",
      "title": "Play Tennis",
      "category": "Smartphone",
      "country": "seocho",
      "price": 18
    },
    {
      "image": "assets/images/image_3.png",
      "title": "with brunch",
      "category": "Smartphone",
      "country": "yanggae",
      "price": 18
    },
    {
      "image": "assets/images/image_1.png",
      "title": "go running!!",
      "category": "Smartphone",
      "country": "",
      "price": 18
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SectionTitle(
          title: "Activities",
          press: () {},
        ),
      ),
      SizedBox(height: getProportionateScreenWidth(20)),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            realtimeActivities.length,
            (index) => ActivityCard(
              image: realtimeActivities[index]["image"],
              title: realtimeActivities[index]["title"],
              country: realtimeActivities[index]["country"],
              price: realtimeActivities[index]["price"],
              press: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(),
                  ),
                );*/
              },
              key: null,
            ),
          ),
        ),
      ),
    ]);
  }
}

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    required Key? key,
    required this.image,
    required this.title,
    required this.country,
    required this.price,
    required this.press,
  }) : super(key: key);

  final String image, title, country;
  final int price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Image.asset(image),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "$title\n".toUpperCase(),
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "$country".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$$price',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
