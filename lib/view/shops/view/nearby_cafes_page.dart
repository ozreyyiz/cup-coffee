import 'package:cup_coffee/core/constants/padding/padding_constants.dart';
import 'package:cup_coffee/core/constants/radius/border_radius_constants.dart';
import 'package:cup_coffee/view/home/model/shop_model.dart';
import 'package:cup_coffee/view/shops/view/reserve_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/components/text/texty.dart';
import '../../../core/constants/color/color_constants.dart';
import '../../../core/size/size_config.dart';
part '../manager/nearby_cafes_page_text_manager.dart';

class NearbyCafesPage extends StatelessWidget {
  final ShopModel shopModel;
  const NearbyCafesPage({Key? key, required this.shopModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(40.22318524068648, 28.85932782863291),
      zoom: 19,
    );
    return Scaffold(
      backgroundColor: ColorConstants.WHITE_BACKGROUND,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _photoBox(context),
            Padding(
              padding: PaddingConstants.pageMainPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  _cafeData(),
                  const SizedBox(
                    height: 200,
                    child: GoogleMap(
                      initialCameraPosition: kGooglePlex,
                      mapType: MapType.normal,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _payBox(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _cafeData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Texty(
              text: shopModel.shopName,
              fontSize: 24,
              color: ColorConstants.BLACK,
            ),
            Row(
              children: [
                Image.asset("assets/images/star.png"),
                Texty(
                  text:
                      "${shopModel.rating}/ ${shopModel.ratingAmount} ratings",
                  fontSize: 14,
                  color: ColorConstants.GREYFONT,
                ),
              ],
            )
          ],
        ),
        const Texty(
          text: _NearbyCafesTextManager.special,
          fontSize: 14,
          color: ColorConstants.BLACK,
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
              text: shopModel.description,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: ColorConstants.GREYFONT,
                fontWeight: FontWeight.w400,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: "...Read More",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: ColorConstants.YELLOW,
                      fontWeight: FontWeight.w400,
                    )),
              ]),
        ),
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
                tag: shopModel.shopName,
                child: ClipRRect(
                  borderRadius: BorderRadiusConstants.bigPictureRadius,
                  child: Container(
                    height: SizeConfig.sizeHeight(context, .45),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusConstants.bigPictureRadius,
                    ),
                    child: Image.network(
                      shopModel.photoUrl,
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
                onTap: () {
                  Navigator.pop(context);
                },
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
                    text: _NearbyCafesTextManager.nearbyShops,
                    fontSize: 18,
                    color: ColorConstants.WHITE),
              ],
            ),
            Positioned(
              bottom: 10,
              left: SizeConfig.sizeWidth(context, .15),
              child: Image.asset("assets/images/pictures.png"),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _payBox(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              ColorConstants.GREENBOX,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusConstants.payBoxRadius,
              ),
            ),
          ),
          onPressed: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => ReservePage(
                          shopModel: shopModel,
                        ))));
          },
          child: const Padding(
            padding: PaddingConstants.payButtonPadding,
            child: Texty(
              text: _NearbyCafesTextManager.viewProduct,
              fontSize: 18,
              color: ColorConstants.WHITE,
            ),
          ),
        ));
  }
}
