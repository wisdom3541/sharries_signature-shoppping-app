import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sharries_signature/main.dart';
import 'package:sharries_signature/model/categoriesModel.dart';
import 'package:sharries_signature/screens/emptyCart.dart';

class Cart extends StatelessWidget {
  Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 32, left: 48, right: 48),
          child: Column(
            children: [
              cartTopbar(),
              const Divider(),
              Container(height: 300, child: cartList(context)),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                ),
                padding: EdgeInsets.only(right: 5, left: 5),
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 2, color: Color.fromRGBO(64, 140, 43, 1))),
                child: Column(
                  children: [
                    cartSummary(context),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: const Divider(
                        height: 1,
                      ),
                    ),
                    altButtomAddToCart(context, Colors.white, "Total Amount"),
                  ],
                ),
              ),
              extras("You might like", Color.fromRGBO(121, 122, 123, 1),
                  "InterFont")
            ],
          ),
        ),
      ),
    );
  }
}

Widget cartTopbar() {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            ImageIcon(AssetImage("images/back2.png")),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: const Text(
                "Cart",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "PoppinsFont",
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )
          ],
        ),
        ImageIcon(AssetImage("images/shoppingCart.png")),
      ],
    ),
  );
}

Widget cartList(BuildContext context) {
  var cartProducts =
      Provider.of<MainAppState>(context, listen: false).productsInCart;
  return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: cartProducts.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return cartItem(cartProducts[index]);
      });
}

Widget cartItem(Categoriesmodel product) {
  return Container(
    margin: EdgeInsets.only(top: 15),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.network(
          product.imageUrl.toString(),
          height: 100,
          width: 90,
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: 150,
                    child: textWidget("RS34670", product.title.toString(),
                        CrossAxisAlignment.start)),
                SizedBox(
                    child: textWidget("Unit price", "\$${product.price}",
                        CrossAxisAlignment.end)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget textWidget(String first, String second, CrossAxisAlignment align) {
  return Column(
    crossAxisAlignment: align,
    children: [
      Text(
        first,
        style: const TextStyle(
            fontSize: 12,
            fontFamily: "PoppinsFont",
            color: Color.fromRGBO(110, 110, 110, 1)),
      ),
      Text(
        second,
        softWrap: true,
        overflow: TextOverflow.visible,
        style: const TextStyle(
            fontSize: 16, fontFamily: "PoppinsFont", color: Colors.black),
      )
    ],
  );
}

Widget cartSummary(BuildContext context) {
  var state = Provider.of<MainAppState>(context, listen: false);
  return Container(
    padding: EdgeInsets.only(top: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Cart Summary",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: "LoraFont"),
        ),
        Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                cartSummaryTextWidget("Sub-total", "\$${state.subTotal}"),
                const SizedBox(
                  height: 20,
                ),
                cartSummaryTextWidget("Delivery", "\$5.00"),
              ],
            )),
      ],
    ),
  );
}

Widget cartSummaryTextWidget(String first, String second) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        first,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: "PoppinsFont",
            color: Color.fromRGBO(110, 110, 110, 1)),
      ),
      const SizedBox(
        width: 63,
      ),
      Text(
        second,
        style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: "LoraFont",
            color: Color.fromRGBO(110, 110, 110, 1)),
      ),
    ],
  );
}

Widget altButtomAddToCart(
    BuildContext context, Color backColour, String first) {
  var state = Provider.of<MainAppState>(context, listen: false);
  return Container(
    height: 90,
    //padding: const EdgeInsets.only(left: 48, right: 48),
    margin: const EdgeInsets.only(top: 10),
    color: backColour,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  // minimumSize: Size(63, 48),
                  side: const BorderSide(color: Colors.black, width: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              onPressed: () {},
              child: const Text(
                "Cancel",
                style: TextStyle(
                    fontFamily: "PoppinsFont",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.black),
              )),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                first,
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "PopppinsFont",
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(121, 122, 123, 1)),
              ),
              Text(
                "\$${state.subTotal + 5}",
                style: const TextStyle(
                    fontSize: 18, fontFamily: "LoraFont", color: Colors.black),
              )
            ],
          ),
        ),
        Container(
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  //minimumSize: Size(120, 50),
                  backgroundColor: Color.fromRGBO(64, 140, 43, 1),
                  //side: const BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              onPressed: () {},
              child: const Text(
                "Checkout",
                style: TextStyle(
                    fontFamily: "PopppinsFont",
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.white),
              )),
        )
      ],
    ),
  );
}
