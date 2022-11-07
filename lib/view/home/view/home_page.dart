import 'package:cup_coffee/core/components/bigCoffeeBox/big_coffee_box.dart';
import 'package:cup_coffee/core/components/bigCoffeeBox/small_coffe_box.dart';
import 'package:cup_coffee/core/constants/color/color_constants.dart';
import 'package:cup_coffee/core/constants/radius/border_radius_constants.dart';
import 'package:cup_coffee/core/components/text/texty.dart';
import 'package:cup_coffee/core/components/text/texty_thin.dart';
import 'package:cup_coffee/core/size/size_config.dart';
import 'package:cup_coffee/view/home/model/coffee_model.dart';
import 'package:cup_coffee/view/home/model/shop_model.dart';
import 'package:cup_coffee/view/home/view/detail_page.dart';
import 'package:cup_coffee/view/home/viewmodel/home_view_model.dart';
import 'package:cup_coffee/view/shops/view/nearby_cafes_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
part '../manager/home_text_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.WHITE_BACKGROUND,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: SizeConfig.sizeHeight(context, 1),
              width: SizeConfig.sizeWidth(context, 1),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(),
                      const SizedBox(height: 10),
                      _searchBar(),
                      const SizedBox(height: 20),
                      _populerCoffeeHeader(),
                      const SizedBox(height: 20),
                      _popularCoffeeRow(),
                      const SizedBox(height: 10),
                      _nearestCoffeeShopsHeader(),
                      const SizedBox(height: 10),
                      _nearestCoffeeShopRow(),
                      const Spacer(),
                      _bottomNavigationBar
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _header() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      text: _HomePageTextManager.getYour,
                      style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: ColorConstants.BLACK,
                        fontWeight: FontWeight.w600,
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: _HomePageTextManager.coffee,
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          color: ColorConstants.YELLOW,
                          fontWeight: FontWeight.w600,
                        )),
                  ])),
              const Texty(
                text: _HomePageTextManager.finger,
                fontSize: 25,
                color: ColorConstants.BLACK,
              ),
            ],
          ),
          Column(
            children: [
              CircleAvatar(
                radius: 58 / 2,
                backgroundColor: ColorConstants.GREY,
                child: FutureBuilder(
                  future: HomeViewModel().getProfileImage(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text(
                        "Something went wrong",
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Image.network(
                        snapshot.data.toString(),
                        fit: BoxFit.cover,
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  SizedBox _searchBar() {
    return SizedBox(
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorConstants.GREY,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadiusConstants.searchBarRadius),
          hintText: _HomePageTextManager.searchLabel,
          prefixIcon: Image.asset("assets/images/search.png"),
        ),
      ),
    );
  }

  SizedBox _populerCoffeeHeader() {
    return const SizedBox(
      child: Texty(
        text: _HomePageTextManager.populerCoffee,
        fontSize: 20,
        color: ColorConstants.BLACK,
      ),
    );
  }

  SizedBox _popularCoffeeRow() {
    return SizedBox(
      height: SizeConfig.sizeHeight(context, 6.2 / 24),
      width: SizeConfig.sizeWidth(context, 1),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            StreamBuilder<List<CoffeeModel>>(
              stream: HomeViewModel().getCoffeeData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List items = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      CoffeeModel coffeeModel = items[index];

                      return _coffeeContainer(
                        coffeeName: coffeeModel.coffeeName,
                        context: context,
                        deliveryTime: coffeeModel.deliveryTime,
                        photoUrl: coffeeModel.photoUrl,
                        price: coffeeModel.price,
                        score: coffeeModel.score,
                        shopName: coffeeModel.shopName,
                        coffeeModel: coffeeModel,
                      );
                    },
                  );
                } else {
                  return Center();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _nearestCoffeeShopsHeader() {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Texty(
            text: _HomePageTextManager.nearestCoffee,
            fontSize: 20,
            color: ColorConstants.BLACK,
          ),
          InkWell(
            child: Texty(
              text: _HomePageTextManager.viewAll,
              fontSize: 14,
              color: ColorConstants.YELLOW,
            ),
          )
        ],
      ),
    );
  }

  Widget _nearestCoffeeShopRow() {
    return SizedBox(
      height: SizeConfig.sizeHeight(context, 5.4 / 24),
      width: SizeConfig.sizeWidth(context, 1),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            StreamBuilder<List<ShopModel>>(
              stream: HomeViewModel().getShopData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List items = snapshot.data;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      ShopModel shopModel = items[index];

                      return _shopContainer(
                        context: context,
                        distance: shopModel.distance,
                        photoUrl: shopModel.photoUrl,
                        ratingAmount: shopModel.ratingAmount,
                        rating: shopModel.rating,
                        shopName: shopModel.shopName,
                        shopModel: shopModel,
                      );
                    },
                  );
                } else {
                  return const Center();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _coffeeContainer({
    required BuildContext context,
    required String photoUrl,
    required String coffeeName,
    required String shopName,
    required String deliveryTime,
    required String score,
    required String price,
    required CoffeeModel coffeeModel,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(coffeeModel: coffeeModel)));
      },
      child: Row(
        children: [
          Column(
            children: [
              BigCoffeeBox(
                height: SizeConfig.sizeHeight(context, 4.5 / 24),
                width: SizeConfig.sizeWidth(context, .55),
                url: photoUrl,
                tag: coffeeName,
                deliveryTime: coffeeModel.deliveryTime,
                rating: coffeeModel.score,
              ),
              SizedBox(
                height: SizeConfig.sizeHeight(context, 1.5 / 24),
                width: SizeConfig.sizeWidth(context, 0.5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texty(
                            text: coffeeName,
                            fontSize: 18,
                            color: ColorConstants.BLACK,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/map-pin.png",
                                scale: 1.5,
                              ),
                              TextyThin(
                                  text: " $shopName",
                                  fontSize: 14,
                                  color: ColorConstants.BLACK)
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/images/money_icon.png"),
                              Texty(
                                  text: " $price",
                                  fontSize: 18,
                                  color: ColorConstants.BLACK)
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _shopContainer({
    required BuildContext context,
    required String photoUrl,
    required String shopName,
    required String distance,
    required String ratingAmount,
    required String rating,
    required ShopModel shopModel,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => NearbyCafesPage(shopModel: shopModel))));
      },
      child: Row(
        children: [
          Column(
            children: [
              SmallCoffeeBox(
                distance: shopModel.distance,
                height: SizeConfig.sizeHeight(context, 3.8 / 24),
                width: SizeConfig.sizeWidth(context, .4),
                url: photoUrl,
              ),
              SizedBox(
                height: SizeConfig.sizeHeight(context, 1.5 / 24),
                width: SizeConfig.sizeWidth(context, 0.4),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texty(
                            text: shopName,
                            fontSize: 16,
                            color: ColorConstants.BLACK,
                          ),
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/star.png",
                                scale: .7,
                              ),
                              TextyThin(
                                text: " $rating / $ratingAmount ratings",
                                fontSize: 10,
                                color: ColorConstants.GREYFONT,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget get _bottomNavigationBar {
    return SizedBox(
      height: SizeConfig.sizeHeight(context, 2 / 24),
      child: bottomNavigationBar,
    );
  }

  Widget get bottomNavigationBar {
    return ClipRRect(
      borderRadius: BorderRadiusConstants.bottomNavigationBarRadius,
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/home.png"), label: "home"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/shopping-bag.png"),
              label: "shopping-bag"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/map-pin.png"), label: "map-pin"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/heart.png"), label: "heart"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/user.png"), label: "user"),
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        showUnselectedLabels: false,
        showSelectedLabels: false,
      ),
    );
  }
}
