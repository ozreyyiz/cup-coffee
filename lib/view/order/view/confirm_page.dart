import 'package:cup_coffee/core/components/text/texty.dart';
import 'package:cup_coffee/core/constants/color/color_constants.dart';
import 'package:cup_coffee/view/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/provider/counter_provider.dart';
import '../viewmodel/order_view_model.dart';

class ConfirmPage extends StatelessWidget {
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderViewModel().cleanOrderList();
    final counter = Provider.of<CounterProvider>(context);

    counter.cleanProvider();

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
            const SizedBox(),
            Column(
              children: [
                Texty(
                  text: "Order Confirmed!",
                  fontSize: 24,
                  color: ColorConstants.BLACK,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) => HomePage())));
                  },
                  child: Text(
                    "back to the homepage",
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.YELLOW,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
