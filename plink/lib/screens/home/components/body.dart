import 'package:flutter/material.dart';
import 'package:plink/screens/home/components/googlemap.dart';

import '../../../size_config.dart';
import 'home_header.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'googlemap.dart';

/*
import 'popular_product.dart';
import 'special_offers.dart';*/

/*
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GoogleMapWidget(),
    );
  }
}
*/

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            child: GoogleMapWidget(),
            width: double.infinity,
            height: getProportionateScreenHeight(700),
            // TODO : CHECK Full height
          ),
          Positioned(child: HomeHeader(), left: 0, top: getProportionateScreenHeight(15)),
          //DiscountBanner(),
          //Categories(),
          /*SpecialOffers(),
          SizedBox(height: getProportionateScreenWidth(30)),
          PopularProducts(),
          SizedBox(height: getProportionateScreenWidth(30)),
          */
        ],
      ),
    );
  }
}
