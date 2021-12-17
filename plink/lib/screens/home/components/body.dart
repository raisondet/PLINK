import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plink/screens/home/components/recommend_activities.dart';
import 'package:plink/screens/home/components/googlemap.dart';
import 'package:plink/screens/home/components/realtime_activities.dart';
import 'package:plink/screens/home/components/special_offers.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../size_config.dart';
import 'home_header.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'googlemap.dart';

/*
import 'popular_product.dart';
import 'special_offers.dart';*/

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
          Positioned(
              child: HomeHeader(),
              left: 0,
              top: getProportionateScreenHeight(15)),
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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final double _initFabHeight = 120.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 100.0;

  @override
  void initState() {
    super.initState();

    _fabHeight = _initFabHeight;
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * .75;

    return Material(
      child: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            buildSlideUpPanel(),
            buildFloatingActionButton(),
            //buildBlurArea(),
            //buildSlideUpPanelTitle(),
          ],
        ),
      ),
    );
  }

  Widget buildSlideUpPanel() {
    return SlidingUpPanel(
      maxHeight: _panelHeightOpen,
      minHeight: _panelHeightClosed,
      parallaxEnabled: true,
      parallaxOffset: .5,
      body: buildMap(),
      panelBuilder: (sc) => buildPanel(sc),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
      onPanelSlide: (double pos) => setState(() {
        _fabHeight =
            pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
      }),
    );
  }

  Widget buildFloatingActionButton() {
    return Positioned(
      // the fab
      right: 20.0,
      bottom: _fabHeight,
      child: FloatingActionButton(
        child: Icon(
          Icons.gps_fixed,
          color: Theme.of(context).primaryColor,
        ),
        onPressed: () {},
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget buildBlurArea() {
    return Positioned(
      top: 0,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).padding.top,
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget buildSlideUpPanelTitle() {
    return Positioned(
      //the SlidingUpPanel Title
      top: 15.0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
        child: Text(
          "PLINK",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
          ],
        ),
      ),
    );
  }

  Widget buildPanel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: sc,
          children: <Widget>[
            SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            Categories(),
            SizedBox(height: getProportionateScreenHeight(10),),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenHeight(30),),
            RealtimeActivities(),
            //SizedBox(height: getProportionateScreenHeight(10),),
            RecommendActivities(),
          ],
        ));
  }

  Widget buildMap() {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(37.2785209, 127.0735166),
        zoom: 16,
        maxZoom: 19,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png"),
        MarkerLayerOptions(markers: [
          Marker(
              point: LatLng(37.2785209, 127.0735166),
              builder: (ctx) => Icon(
                    Icons.location_on,
                    color: Colors.blue,
                    size: 48.0,
                  ),
              height: 60),
        ]),
      ],
    );
  }
}
