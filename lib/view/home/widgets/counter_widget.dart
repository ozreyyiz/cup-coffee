import 'package:flutter/material.dart';

import '../../../core/components/text/texty.dart';
import '../../../core/constants/color/color_constants.dart';
import '../provider/counter_provider.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    Key? key,
    required this.counter,
    required this.count,
    required this.size,
    required this.fontSize,
    required this.function,
  }) : super(key: key);

  final CounterProvider counter;
  final int count;
  final double size;
  final double fontSize;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: () {
            counter.decrement();
            function();
          },
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: ColorConstants.YELLOW.withOpacity(.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Texty(
                text: "-",
                fontSize: fontSize,
                color: ColorConstants.YELLOW,
              ),
            ),
          ),
        ),
        Texty(
          text: count.toString(),
          fontSize: 20,
          color: ColorConstants.BLACK,
        ),
        InkWell(
          onTap: () {
            counter.increment();
         
        
              function();
          
          },
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: ColorConstants.YELLOW,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Texty(
                text: "+",
                fontSize: 16,
                color: ColorConstants.WHITE,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
