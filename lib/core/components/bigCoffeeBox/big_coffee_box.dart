import 'dart:ui';

import 'package:cup_coffee/core/components/text/texty.dart';
import 'package:cup_coffee/core/constants/color/color_constants.dart';
import 'package:flutter/material.dart';

import '../../constants/radius/border_radius_constants.dart';

class BigCoffeeBox extends StatelessWidget {
  final double height;
  final double width;
  final String url;
  final String tag;
  final String deliveryTime;
  final String rating;

  const BigCoffeeBox({
    Key? key,
    required this.height,
    required this.width,
    required this.url,
    required this.tag,
    required this.deliveryTime,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadiusConstants.bigBoxRadius,
          ),
          child: Stack(
            children: [
              SizedBox(height: height,
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Row(
                  children: [
                    Image.asset("assets/images/clock.png"),
                    Texty(
                      text: " $deliveryTime min delivery",
                      fontSize: 14,
                      color: ColorConstants.WHITE,
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: Row(
                    children: [
                      Image.asset("assets/images/star.png"),
                      Texty(
                        text: rating,
                        fontSize: 14,
                        color: ColorConstants.WHITE,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
