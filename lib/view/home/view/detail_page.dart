import 'package:cup_coffee/core/components/text/texty.dart';
import 'package:cup_coffee/core/components/text/texty_normal.dart';
import 'package:cup_coffee/core/constants/color/color_constants.dart';
import 'package:cup_coffee/core/constants/padding/padding_constants.dart';
import 'package:cup_coffee/core/constants/radius/border_radius_constants.dart';
import 'package:cup_coffee/core/size/size_config.dart';
import 'package:cup_coffee/view/home/model/coffee_model.dart';
import 'package:cup_coffee/view/home/provider/amount_provider.dart';
import 'package:cup_coffee/view/home/provider/counter_provider.dart';
import 'package:cup_coffee/view/home/viewmodel/home_view_model.dart';
import 'package:cup_coffee/view/order/view/order_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../widgets/counter_widget.dart';
part '../manager/detail_page_text_manager.dart';

class DetailPage extends StatelessWidget {
  final CoffeeModel coffeeModel;
  const DetailPage({Key? key, required this.coffeeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final amount = Provider.of<AmountProvider>(context);
    final coffeeAmount = amount.amount;
    final counter = Provider.of<CounterProvider>(context);
    final count = counter.count;
    return Scaffold(
      backgroundColor: ColorConstants.WHITE_BACKGROUND,
      body: SingleChildScrollView(
        child: Column(
          children: [
           const SizedBox(height: 10),
            _photoBox(context),
            Padding(
              padding: PaddingConstants.detailPageMainPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _descriptionBox(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _smallBox(pictureName: "coffee"),
                      _smallBox(pictureName: "milk"),
                      _smallBox(pictureName: "cream"),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _orderChartBox(context, amount, coffeeAmount, counter, count),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _orderChartBox(BuildContext context, AmountProvider amount,
      int coffeeAmount, CounterProvider counter, int count) {
    return SizedBox(
      height: SizeConfig.sizeHeight(context, .25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Texty(
            text: _DetailPageTextManager.size,
            fontSize: 18,
            color: ColorConstants.BLACK,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  int ml = 100;
                  amount.amountUpdate(ml);
                },
                child: Container(
                  width: SizeConfig.sizeWidth(context, .25),
                  height: 37,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorConstants.GREENBOX,
                      ),
                      color: coffeeAmount == 100
                          ? ColorConstants.GREENBOX
                          : ColorConstants.WHITE,
                      borderRadius: BorderRadiusConstants.coffeeAmountRadius),
                  child: Center(
                    child: TextyNormal(
                      text: _DetailPageTextManager.ml100,
                      fontSize: 18,
                      color: coffeeAmount == 100
                          ? ColorConstants.WHITE
                          : ColorConstants.GREENBOX,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  int ml = 250;
                  amount.amountUpdate(ml);
                },
                child: Container(
                  width: SizeConfig.sizeWidth(context, .25),
                  height: 37,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstants.GREENBOX,
                    ),
                    color: coffeeAmount == 250
                        ? ColorConstants.GREENBOX
                        : ColorConstants.WHITE,
                    borderRadius: BorderRadiusConstants.coffeeAmountRadius,
                  ),
                  child: Center(
                    child: TextyNormal(
                      text: _DetailPageTextManager.ml250,
                      fontSize: 18,
                      color: coffeeAmount == 250
                          ? ColorConstants.WHITE
                          : ColorConstants.GREENBOX,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  int ml = 500;
                  amount.amountUpdate(ml);
                },
                child: Container(
                  width: SizeConfig.sizeWidth(context, .25),
                  height: 37,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstants.GREENBOX,
                    ),
                    color: coffeeAmount == 500
                        ? ColorConstants.GREENBOX
                        : ColorConstants.WHITE,
                    borderRadius: BorderRadiusConstants.coffeeAmountRadius,
                  ),
                  child: Center(
                    child: TextyNormal(
                      text: _DetailPageTextManager.ml500,
                      fontSize: 18,
                      color: coffeeAmount == 500
                          ? ColorConstants.WHITE
                          : ColorConstants.GREENBOX,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: SizeConfig.sizeWidth(context, .4),
                child: CounterWidget(
                    function: () {},
                    counter: counter,
                    count: count,
                    size: 40,
                    fontSize: 16),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    ColorConstants.GREENBOX,
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusConstants.addToCartRadius,
                    ),
                  ),
                ),
                onPressed: () async {
                  HomeViewModel().cleanOrderList();

                  Future.delayed(const Duration(seconds: 1), (() {
                    HomeViewModel().addToCart(
                        itemAmount: count.toString(),
                        model: coffeeModel,
                        coffeeAmount: coffeeAmount.toString());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OrderPage()));
                  }));
                },
                child: const Padding(
                  padding: PaddingConstants.addToCartPadding,
                  child: Texty(
                    text: _DetailPageTextManager.addToCart,
                    fontSize: 18,
                    color: ColorConstants.WHITE,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _descriptionBox(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Texty(
              text: coffeeModel.coffeeName,
              fontSize: 24,
              color: ColorConstants.BLACK,
            ),
            Row(
              children: [
                Image.asset("assets/images/star.png"),
                Texty(
                  text: coffeeModel.score,
                  fontSize: 18,
                  color: ColorConstants.BLACK,
                ),
              ],
            ),
          ],
        ),
        Texty(
          text: "£ (${coffeeModel.price})",
          fontSize: 20,
          color: ColorConstants.BLACK,
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
              text: coffeeModel.description,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: ColorConstants.GREYFONT,
                fontWeight: FontWeight.w400,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: ".Read More",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: ColorConstants.YELLOW,
                      fontWeight: FontWeight.w400,
                    )),
              ]),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  SizedBox _photoBox(BuildContext context) {
    return SizedBox(
      height: SizeConfig.sizeHeight(context, .45),
      child: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: PaddingConstants.picturePadding,
              child: Hero(
                tag: coffeeModel.coffeeName,
                child: ClipRRect(
                  borderRadius: BorderRadiusConstants.bigPictureRadius,
                  child: Container(
                    height: SizeConfig.sizeHeight(context, .45),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadiusConstants.bigPictureRadius,
                    ),
                    child: Image.network(
                      coffeeModel.photoUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: SizeConfig.sizeWidth(context, .08),
              top: 10,
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: ColorConstants.WHITE.withOpacity(.25),
                    borderRadius: BorderRadiusConstants.iconRadius,
                  ),
                  child: Center(
                    child: Image.asset("assets/images/arrow_white.png"),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Texty(
                    text: _DetailPageTextManager.details,
                    fontSize: 18,
                    color: ColorConstants.WHITE),
              ],
            ),
            Positioned(
              right: SizeConfig.sizeWidth(context, .08),
              top: 10,
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: ColorConstants.WHITE.withOpacity(.25),
                    borderRadius: BorderRadiusConstants.iconRadius,
                  ),
                  child: Center(
                    child: Image.asset("assets/images/heart_white.png"),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _smallBox({required String pictureName}) {
    return Container(
      height: 73.3,
      width: 73.3,
      decoration: BoxDecoration(
        color: ColorConstants.YELLOW.withOpacity(.1),
        borderRadius: BorderRadiusConstants.materialIconRadius,
      ),
      child: Center(
        child: Image.asset("assets/images/$pictureName.png"),
      ),
    );
  }
}
