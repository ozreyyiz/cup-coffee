import 'package:cup_coffee/core/components/text/texty.dart';
import 'package:cup_coffee/core/components/text/texty_thin.dart';
import 'package:cup_coffee/core/constants/color/color_constants.dart';
import 'package:cup_coffee/core/constants/padding/padding_constants.dart';
import 'package:cup_coffee/core/constants/radius/border_radius_constants.dart';
import 'package:cup_coffee/view/home/model/shop_model.dart';
import 'package:cup_coffee/view/shops/viewmodel/shops_view_model.dart';
import 'package:flutter/material.dart';

import '../../home/model/coffee_model.dart';
part '../manager/reserve_page_text_manager.dart';

class ReservePage extends StatelessWidget {
  final ShopModel shopModel;
  const ReservePage({Key? key, required this.shopModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.WHITE_BACKGROUND,
      appBar: _appBar(context),
      body: Padding(
        padding: PaddingConstants.reservePageMainPadding,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _reserveBox(),
              _coffees(),
            ],
          ),
        ),
      ),
    );
  }

  DefaultTabController _coffees() {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 6,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: const EdgeInsets.all(0),
                  labelColor: ColorConstants.BLACK,
                  unselectedLabelColor: ColorConstants.GREYFONT,
                  tabs: [
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            _ReservePageTextManager.coffees,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Tab(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text(
                            _ReservePageTextManager.cakes,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 4,
                child: Image.asset("assets/images/settings.png"),
              )
            ],
          ),
          SizedBox(
            height: 2000,
            child: TabBarView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        _ReservePageTextManager.todaysSpecial,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    StreamBuilder(
                      stream: ShopsViewModel().getCoffeeData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          List items = snapshot.data;
                          return SizedBox(
                            height: 500,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2 / 2.8,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                              ),
                              itemCount: items.length,
                              itemBuilder: (BuildContext context, int index) {
                                CoffeeModel coffeeModel = items[index];

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadiusConstants
                                            .reserveCartRadius,
                                        child: Image.network(
                                          coffeeModel.photoUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Texty(
                                      text: coffeeModel.coffeeName,
                                      fontSize: 14,
                                      color: ColorConstants.BLACK,
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                            "assets/images/money_icon.png"),
                                        SizedBox(width: 5),
                                        TextyThin(
                                          text: coffeeModel.price,
                                          fontSize: 14,
                                          color: ColorConstants.BLACK,
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          );
                        } else {
                          return Center();
                        }
                      },
                    ),
                  ],
                ),
                const Center(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _reserveBox() {
    return Container(
      height: 117,
      decoration: BoxDecoration(
        color: ColorConstants.WHITE,
        borderRadius: BorderRadiusConstants.totalBoxRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusConstants.reserveBoxRadius,
            child: Container(
                height: 117,
                width: 90,
                child: Image.network(
                  shopModel.photoUrl,
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            width: 180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Texty(
                  text: _ReservePageTextManager.reserve,
                  fontSize: 18,
                  color: ColorConstants.BLACK,
                ),
                SizedBox(height: 10),
                Texty(
                  text: _ReservePageTextManager.lorem,
                  fontSize: 12,
                  color: ColorConstants.GREYFONT,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/arrow_line.png"),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Texty(
        text: shopModel.shopName,
        fontSize: 18,
        color: ColorConstants.BLACK,
      ),
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset("assets/images/arrow_black.png")),
    );
  }
}
