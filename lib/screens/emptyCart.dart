import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sharries_signature/main.dart';
import 'package:sharries_signature/screens/productFullDescription.dart';

class Emptycart extends StatelessWidget {
  const Emptycart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 34),
        margin: EdgeInsets.only(right: 48, left: 48),
        child: Column(
          children: [
            topbar(context),
            Container(
              margin: EdgeInsets.only(top: 80),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image.asset("images/shoppingcartLogo.png"),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: const Text(
                        "Your Cart is empty",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: "LoraFont",
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: const Text(
                        "Explore our collections today and start your journey towards radiant beauty. Your skin will thank you",
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(129, 129, 129, 1),
                            fontSize: 12,
                            fontFamily: "PopppinsFont",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 32),
                      child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(64, 140, 43, 1),
                              minimumSize: Size(160, 48),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          child: const Text(
                            "Start Shopping",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: "InterFont",
                                fontWeight: FontWeight.w500),
                          )),
                    )
                  ],
                ),
              ),
            ),
            extras(
              "Recently viewed",
              Color.fromRGBO(64, 140, 43, 1),
              "PoppinsFont",
            )
          ],
        ),
      ),
    );
  }
}

Widget extras(String first, Color color, String fontType) {
  return Container(
    margin: EdgeInsets.only(top: 32),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            first,
            style: TextStyle(
                fontSize: 14, fontFamily: fontType, color: Colors.black),
          ),
          Text(
            "View all",
            style: TextStyle(
                fontSize: 12, fontFamily: "PoppinsFont", color: color),
          ),
        ],
      ),
      const Divider(
        height: 1,
        color: Color.fromRGBO(204, 203, 203, 1),
      ),
      Container(
        margin: EdgeInsets.only(top: 48),
        //height: 210,
        width: 160,
        // child: dealsGridChild()
      )
    ]),
  );
}
