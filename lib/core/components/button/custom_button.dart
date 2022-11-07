import 'package:flutter/material.dart';

import '../../constants/color/color_constants.dart';
import '../text/texty.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;
  final Function function;
  const CustomButton({
    Key? key,
    required this.text,
    required this.padding,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          ColorConstants.GREENBOX,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            // Change your radius here
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      onPressed: function(),
      child: Padding(
        padding: padding,
        child: Texty(
          text: text,
          fontSize: 18,
          color: ColorConstants.WHITE,
        ),
      ),
    );
  }
}
