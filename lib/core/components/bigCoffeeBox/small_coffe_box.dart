import 'package:cup_coffee/core/components/text/texty.dart';
import 'package:cup_coffee/core/constants/color/color_constants.dart';
import 'package:flutter/material.dart';

import '../../constants/radius/border_radius_constants.dart';

class SmallCoffeeBox extends StatelessWidget {
  final double height;
  final double width;
  final String url;
  final String distance;
  const SmallCoffeeBox(
      {Key? key,
      required this.height,
      required this.width,
      required this.url,
      required this.distance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusConstants.smallBoxRadius,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadiusConstants.smallBoxRadius,
        ),
        child: Stack(
          children: [
            SizedBox(
              height: height,
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(25)),
                    color: ColorConstants.GREY.withOpacity(.4)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: ColorConstants.WHITE,
                    ),
                    Texty(
                      text: "$distance km",
                      fontSize: 2,
                      color: ColorConstants.WHITE,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
