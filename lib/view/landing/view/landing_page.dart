import 'package:cup_coffee/core/constants/color/color_constants.dart';
import 'package:cup_coffee/core/size/size_config.dart';
import 'package:cup_coffee/view/home/view/home_page.dart';
import 'package:cup_coffee/view/landing/view_model/landing_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool isLoading = false;
  String backgroundImageUrl = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.signInAnonymously();
    Future.delayed(const Duration(seconds: 4), () async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundImage(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Spacer(flex: 8),
                  _header(),
                  const Spacer(flex: 3),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _backgroundImage(BuildContext context) {
    return Container(
      height: SizeConfig.sizeHeight(context, 1),
      width: SizeConfig.sizeWidth(context, 1),
      child: Image.asset(
        "assets/images/cup-coffee.png",
        fit: BoxFit.cover,
      ),
    );
  }

  RichText _header() {
    return RichText(
      text: TextSpan(
        text: 'Cup ',
        style: _cupTextStyle(),
        children: <TextSpan>[
          TextSpan(
            text: 'Coffee',
            style: _coffeeTextStyle(),
          ),
        ],
      ),
    );
  }

  TextStyle _cupTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: "Comic Sans",
      fontSize: 50,
      color: ColorConstants.WHITE,
    );
  }

  TextStyle _coffeeTextStyle() {
    return TextStyle(
        fontWeight: FontWeight.bold,
        color: ColorConstants.YELLOW,
        fontFamily: "Comic Sans",
        fontSize: 50);
  }
}
