import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharries_signature/main.dart';
import 'package:sharries_signature/screens/cart.dart';

class Productfulldescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mainAppState = Provider.of<MainAppState>(context, listen: true);
    var whichCart = mainAppState.isProductAdded;
    Widget buttomCart;

    switch (whichCart) {
      case false:
        buttomCart = buttomAddToCart(context);
        print(whichCart);
        break;

      case true:
        buttomCart = altButtomAddToCart(
            context, Color.fromRGBO(202, 236, 192, 1), "Unit price");
        print(whichCart);
        break;
    }

    // if (mainAppState.isProductAdded) {
    //   buttomCart = altButtomAddToCart(context, mainAppState,
    //       Color.fromRGBO(202, 236, 192, 1), "Unit price");
    // } else if (!mainAppState.isProductAdded) {
    //   buttomCart = buttomAddToCart();
    // }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              productBackgroundImage(context),
              productImage(),
              productDetails(),
              buttomCart
              // buttomAddToCart(),
              // altButtomAddToCart(Color.fromRGBO(202, 236, 192, 1), "Unit price")
            ],
          ),
        ),
      ),
    );
  }
}

Widget stackedCartIcon(int itemNum) {
  return SizedBox(
    height: 25,
    width: 30,
    child: Stack(
      children: [
        const ImageIcon(
          AssetImage("images/shoppingCart.png"),
        ),
        Positioned(
            left: 25,
            //top: 5,
            child: Text(
              itemNum.toString(),
              style: TextStyle(fontSize: 10),
            ))
      ],
    ),
  );
}

Widget productBackgroundImage(BuildContext context) {
  return Center(
      child: SizedBox(
    //width: 300,
    height: 415,
    child: Center(
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: <Widget>[
          Container(
            child: Image.asset(
              "images/background.png",
              //width: 300,
              height: 435,
            ),
            //color: Colors.red,
          ), //Container
          Positioned(
              top: 33,
              left: 48,
              right: 48,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.only(left: 48 , right: 48, top: ),
                  child: topbar(context))),
          Positioned(
            top: 100,
            left: 100,
            child: Container(
              child: Image.asset(
                "images/backgroundSplash.png",
                height: 280,
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 120,
            child: Container(
              child: Image.asset(
                "images/scrubImage.png",
                height: 200,
              ),
            ),
          ),
        ],
      ),
    ),
  ));
}

Widget topbar(BuildContext context) {
  var cartNum =
      Provider.of<MainAppState>(context, listen: false).productsInCart.length;
  return Container(
    margin: const EdgeInsets.only(top: 33),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      //mainAxisSize: MainAxisSize.max,
      children: [
        const ImageIcon(
          AssetImage(
            "images/back.png",
          ),

          //color: Colors.white,
        ),
        //ImageIcon(AssetImage("images/shoppingCart.png")),

        stackedCartIcon(cartNum)
      ],
    ),
  );
}

Widget productImage() {
  return Container(
    height: 200,
    //color: Colors.cyan,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            flex: 1,
            child: Image.asset(
              height: 200,
              "images/productImage2.png",
              fit: BoxFit.cover,
            )),
        Expanded(
            flex: 1,
            child: Image.asset(
              height: 200,
              "images/productImage3.png",
              fit: BoxFit.cover,
            )),
      ],
    ),
  );
}

Widget productDetails() {
  return Container(
    margin: const EdgeInsets.only(right: 48.5, left: 48.5, top: 60),
    child: Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "RS34670",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(110, 110, 110, 1),
                  fontFamily: "PopppinsFont"),
            ),
            Text(
              "In Stock",
              style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(64, 140, 43, 1),
                  fontFamily: "PopppinsFont"),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 32),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Repair Scrub",
            style: TextStyle(
                fontSize: 24,
                fontFamily: "PoppinsFont",
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 32),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Our Repair Body Scrub is expertly crafted to rejuvenate and revitalize your skin. This luxurious scrub combines natural exfoliants with nourishing ingredients to gently remove dead skin cells, promote cell renewal, and restore your skin's natural radiance.",
            softWrap: true,
            style: TextStyle(
                fontSize: 14,
                fontFamily: "PoppinsFont",
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(90, 90, 90, 1)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 32),
          alignment: Alignment.centerLeft,
          child: const Text(
            "Made with pure natural ingredients",
            softWrap: true,
            style: TextStyle(
                fontSize: 12,
                fontFamily: "PoppinsFont",
                fontWeight: FontWeight.w400,
                color: Color.fromRGBO(78, 171, 53, 1)),
          ),
        ),
        dropDown("How to use", 40),
        dropDown("Delivery and drop-off", 24),
      ],
    ),
  );
}

Widget dropDown(String dropdownValue, double topMargin) {
  return Container(
    margin: EdgeInsets.only(top: topMargin),
    //padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                dropdownValue,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_drop_down),
              onPressed: () {},
            ),
          ],
        ),
        const Divider(
          height: 5,
          color: Color.fromRGBO(204, 203, 203, 1),
        ),
      ],
    ),
  );
}

Widget buttomAddToCart(BuildContext context) {
  return Container(
    height: 90,
    padding: const EdgeInsets.only(left: 48, right: 48),
    margin: const EdgeInsets.only(top: 22),
    color: const Color.fromRGBO(64, 140, 43, 1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sub",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "PopppinsFont",
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(250, 250, 250, 1)),
              ),
              Text(
                "\$19.00",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "LoraFont",
                    color: Color.fromRGBO(250, 250, 250, 1)),
              )
            ],
          ),
        ),
        Container(
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  minimumSize: Size(152, 40),
                  side: const BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              onPressed: () {
                Provider.of<MainAppState>(context, listen: false)
                    .updateIsProductAdded(true);
              },
              child: const Text(
                "Add to cart",
                style: TextStyle(
                    fontFamily: "PoppinsFont",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.white),
              )),
        )
      ],
    ),
  );
}

Widget altButtomAddToCart(
    BuildContext context, Color backColour, String first) {
  return Container(
    height: 90,
    //padding: const EdgeInsets.only(left: 48, right: 48),
    margin: const EdgeInsets.only(top: 22),
    color: backColour,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  // minimumSize: Size(63, 48),
                  side: const BorderSide(color: Colors.black, width: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              onPressed: () {
                Provider.of<MainAppState>(context, listen: false)
                    .updateIsProductAdded(false);
              },
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
                    fontSize: 16,
                    fontFamily: "PopppinsFont",
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(121, 122, 123, 1)),
              ),
              const Text(
                "\$19.00",
                style: TextStyle(
                    fontSize: 20, fontFamily: "LoraFont", color: Colors.black),
              )
            ],
          ),
        ),
        Container(
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                  minimumSize: Size(120, 50),
                  backgroundColor: Color.fromRGBO(64, 140, 43, 1),
                  //side: const BorderSide(color: Colors.white, width: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              onPressed: () {
                //state.updateIsProductAdded(true);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              },
              child: const Text(
                "Checkout",
                style: TextStyle(
                    fontFamily: "PoppinsFont",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Colors.white),
              )),
        )
      ],
    ),
  );
}
