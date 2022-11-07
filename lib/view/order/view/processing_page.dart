import 'package:cup_coffee/core/components/text/texty.dart';
import 'package:cup_coffee/core/constants/color/color_constants.dart';
import 'package:cup_coffee/view/order/view/confirm_page.dart';
import 'package:cup_coffee/view/order/viewmodel/order_view_model.dart';
import 'package:flutter/material.dart';

class ProcessingPage extends StatelessWidget {
  const ProcessingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), (() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: ((context) => ConfirmPage())));
    }));
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(),
          Image.asset(
            "assets/images/lottie.png",
            fit: BoxFit.cover,
          ),
          Texty(
              text: "Your order is processing",
              fontSize: 24,
              color: ColorConstants.BLACK),
          SizedBox(),
        ],
      ),
    );
  }
}
