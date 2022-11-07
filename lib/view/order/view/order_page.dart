import 'package:cup_coffee/core/components/text/texty.dart';
import 'package:cup_coffee/core/components/text/texty_thin.dart';
import 'package:cup_coffee/core/constants/color/color_constants.dart';
import 'package:cup_coffee/core/constants/padding/padding_constants.dart';
import 'package:cup_coffee/core/constants/radius/border_radius_constants.dart';
import 'package:cup_coffee/core/size/size_config.dart';
import 'package:cup_coffee/view/home/widgets/counter_widget.dart';
import 'package:cup_coffee/view/order/model/order_model.dart';
import 'package:cup_coffee/view/order/view/processing_page.dart';
import 'package:cup_coffee/view/order/viewmodel/order_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/provider/counter_provider.dart';

part '../manager/order_text_manager.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context, listen: true);
    final count = counter.count;

    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
          child: Padding(
        padding: PaddingConstants.pageMainPadding,
        child: Column(
          children: [
            _deliveryBox(context),
            const SizedBox(height: 37),
            _orderDataBox(counter, count),
            const SizedBox(height: 40),
            _payBox(context),
            const SizedBox(height: 20),
          ],
        ),
      )),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Image.asset("assets/images/arrow_black.png"),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: const Texty(
        text: _OrderTextManager.placeHolder,
        fontSize: 18,
        color: ColorConstants.BLACK,
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
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: ((context) => const ProcessingPage())));
        },
        child: const Padding(
          padding: PaddingConstants.payButtonPadding,
          child: Texty(
            text: _OrderTextManager.pay,
            fontSize: 18,
            color: ColorConstants.WHITE,
          ),
        ),
      ),
    );
  }

  SizedBox _orderDataBox(CounterProvider counter, int count) {
    return SizedBox(
      height: 400,
      child: StreamBuilder(
        stream: OrderViewModel().getOrderData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List items = snapshot.data;
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                OrderModel order;
                if (index == null) {
                  return const CircularProgressIndicator();
                } else {
                  order = items[index];
                }

                return Column(
                  children: [
                    _orderAmountBox(context, order, counter, count),
                    const SizedBox(height: 37),
                    _totalBox(order),
                  ],
                );
              },
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }

  Container _totalBox(OrderModel order) {
    return Container(
      width: double.infinity,
      height: 275,
      decoration: BoxDecoration(
        color: ColorConstants.WHITE,
        borderRadius: BorderRadiusConstants.totalBoxRadius,
      ),
      child: Padding(
        padding: PaddingConstants.totalBoxPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _dataRow(
                title: _OrderTextManager.selected, amount: order.itemAmount),
            _divider(),
            _dataRow(
                title: _OrderTextManager.subtotal,
                amount:
                    "${double.parse(order.price) * double.parse(order.itemAmount)}"),
            _divider(),
            _dataRow(title: _OrderTextManager.discount, amount: "90"),
            _divider(),
            _dataRow(title: _OrderTextManager.delivery, amount: "50"),
            _divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Texty(
                  text: _OrderTextManager.total,
                  fontSize: 18,
                  color: ColorConstants.BLACK,
                ),
                Row(
                  children: [
                    Image.asset("assets/images/money_icon.png"),
                    Texty(
                      text:
                          "${double.parse(order.price) * double.parse(order.itemAmount) - 40}",
                      fontSize: 18,
                      color: ColorConstants.BLACK,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _orderAmountBox(BuildContext context, OrderModel order,
      CounterProvider counter, int count) {
    return Container(
      height: 106,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorConstants.WHITE,
        borderRadius: BorderRadiusConstants.orderAmountBoxRadius,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusConstants.orderAmountBoxRadius,
            child: Container(
              width: SizeConfig.sizeWidth(context, .2),
              height: 106,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusConstants.orderAmountBoxRadius,
              ),
              child: Image.network(
                order.photoUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: SizeConfig.sizeWidth(context, .3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Texty(
                  text: order.orderItem,
                  fontSize: 18,
                  color: ColorConstants.BLACK,
                ),
                Texty(
                  text: "One ${order.coffeeAmount} ml with extra ice",
                  fontSize: 14,
                  color: ColorConstants.GREYFONT,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: SizeConfig.sizeWidth(context, .25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CounterWidget(
                  counter: counter,
                  count: count,
                  fontSize: 20,
                  size: 30,
                  function: () {
                    OrderViewModel().updateData(count);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _deliveryBox(BuildContext context) {
    return Container(
      height: 256,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadiusConstants.bigBoxRadius,
      ),
      child: Row(
        children: [
          SizedBox(
            width: SizeConfig.sizeWidth(context, .2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/map-pin-orange.png"),
                Image.asset("assets/images/line.png"),
                Image.asset("assets/images/life-buoy.png"),
              ],
            ),
          ),
          SizedBox(
            width: SizeConfig.sizeWidth(context, .4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: const [
                    Texty(
                      text: _OrderTextManager.loc1,
                      fontSize: 18,
                      color: ColorConstants.BLACK,
                    ),
                    Texty(
                      text: _OrderTextManager.adress1,
                      fontSize: 14,
                      color: ColorConstants.GREYFONT,
                    ),
                  ],
                ),
                Column(
                  children: const [
                    Texty(
                      text: _OrderTextManager.loc2,
                      fontSize: 18,
                      color: ColorConstants.BLACK,
                    ),
                    Texty(
                      text: _OrderTextManager.adress2,
                      fontSize: 14,
                      color: ColorConstants.GREYFONT,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: SizeConfig.sizeWidth(context, .2),
            child: Column(
              children: [
                const SizedBox(height: 20),
                InkWell(
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: ColorConstants.YELLOW.withOpacity(.1),
                      borderRadius: BorderRadiusConstants.editButtonRadius,
                    ),
                    child: Center(
                      child: Image.asset("assets/images/edit-3.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Divider _divider() {
    return const Divider(
      height: 2,
      color: Colors.black,
    );
  }

  Row _dataRow({required String title, required String amount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextyThin(
          text: title,
          fontSize: 16,
          color: ColorConstants.BLACK,
        ),
        Row(
          children: [
            Image.asset("assets/images/money_icon.png"),
            TextyThin(
              text: " $amount",
              fontSize: 16,
              color: ColorConstants.BLACK,
            ),
          ],
        ),
      ],
    );
  }
}
