import 'package:flutter/material.dart';

class SizeConfig {
 static double sizeWidth(BuildContext context,double value) => (MediaQuery.of(context).size.width * value);

static double sizeHeight(BuildContext context,double value) => (MediaQuery.of(context).size.height * value);
}
