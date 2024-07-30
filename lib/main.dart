import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/retry.dart';
import 'package:provider/provider.dart';
import 'package:sharries_signature/model/categoriesModel.dart';
import 'package:sharries_signature/screens/cart.dart';
import 'package:sharries_signature/screens/productFullDescription.dart';
import 'package:sharries_signature/screens/emptycart.dart';
import 'package:sharries_signature/services/category_services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainAppState(),
      child: MaterialApp(
        home: Scaffold(
          body: HomePage(),
        ),
      ),
    );
  }
}

Color neutral = Color.fromRGBO(54, 57, 57, 1);

class MainAppState extends ChangeNotifier {
  //late Future<List<Categoriesmodel>> just;

  List<Categoriesmodel> productsInCart = [];
  double subTotal = 0;
  bool isProductAdded = false;

  void updateCartItems(Categoriesmodel product) {
    productsInCart.add(product);
    notifyListeners();
  }

  void removeCartItem(Categoriesmodel product) {
    productsInCart.remove(product);
    notifyListeners();
  }

  void updateCartSubTotal(double price) {
    subTotal += price;
    notifyListeners();
  }

  void subtractCartSubTotal(double price) {
    subTotal -= price;
    notifyListeners();
  }

  void updateIsProductAdded(bool value) {
    isProductAdded = value;
    notifyListeners();
  }

  var just =
      CategoryServices(catergorySection: "justforyou").fetchCategoryDetails();

  var deals =
      CategoryServices(catergorySection: "deals").fetchCategoryDetails();

  var mightLike =
      CategoryServices(catergorySection: "youmightlike").fetchCategoryDetails();
}

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late MainAppState appState;

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<MainAppState>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: PreferredSize(
      //     preferredSize: Size.fromHeight(200), child: customAppBar()),
      bottomNavigationBar: navigationBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(right: 48, left: 48, top: 45),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                  ),
                  child: customAppBar(context, appState.productsInCart.length)),
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 43),
                //padding: const EdgeInsets.only(left: 48),
                child: const Text(
                  "Welcome, Jane",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: "PopppinsFont",
                      fontWeight: FontWeight.bold),
                ),
              ),
              //search bar
              Container(
                margin: const EdgeInsets.only(top: 16),
                height: 48,
                child: const TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      )),
                ),
              ),
              //search bar end

              //Just for you -- start
              Padding(
                padding: const EdgeInsets.only(
                  top: 48,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Just for you",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(54, 57, 57, 1),
                          fontFamily: "LoraFont",
                          fontWeight: FontWeight.bold),
                    ),
                    chevronIconLeftRight(),

                    //list below
                    // listJustForYou()
                  ],
                ),
              ),
              //Just for you -- end

              listJustForYou(context),
              deals("Deals"),
              gridLayout(context, appState.deals, 235, 32, appState),
              collectionSection(),
              deals("You Might Like"),
              gridLayout(context, appState.mightLike, 235, 32, appState),
            ],
          ),
        ),
      ),
    );
  }
}

Widget navigationBar() {
  return NavigationBar(destinations: const [
    NavigationDestination(
        icon: ImageIcon(AssetImage("images/home.png")), label: "home"),
    NavigationDestination(
        icon: ImageIcon(AssetImage("images/wishlist.png")), label: "Wishlist"),
    NavigationDestination(
        icon: ImageIcon(AssetImage("images/profile.png")), label: "Profile"),
    NavigationDestination(
        icon: ImageIcon(AssetImage("images/search.png")), label: "Search"),
  ]
      //selectedIndex: selectedIndex,
      );
}

Widget customAppBar(BuildContext context, int count) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        'Sharries\'s Signature',
        style: TextStyle(
            fontSize: 24,
            fontFamily: "RedressedFont",
            color: Color.fromRGBO(64, 140, 43, 1)),
      ),
      GestureDetector(
        onTap: () {
          var itemCount = Provider.of<MainAppState>(context, listen: false)
              .productsInCart
              .length;

          if (itemCount == 0) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Emptycart()));
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Cart()));
          }
        },
        child: stackedCartIcon(count),
        // child: Image.asset(
        //   alignment: Alignment.centerRight,
        //   'images/shopping_cart.png',
        //   width: 20.0,
        //   height: 20.0,
        // ),
      ),
    ],
  );
}

Widget chevronIconLeftRight() {
  return const Row(
    children: [
      Padding(
        padding: EdgeInsets.zero,
        child: Icon(
          Icons.chevron_left,
          size: 20,
        ),
      ),
      SizedBox(
        width: 4,
      ),
      Padding(
          padding: EdgeInsets.zero,
          child: Icon(
            Icons.chevron_right,
            size: 20,
          ))
    ],
  );
}

Widget listJustForYou(BuildContext context) {
  var appState = Provider.of<MainAppState>(context, listen: true);
  return FutureBuilder<List<Categoriesmodel>>(
      future: appState.just,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              height: 225,
              child: const Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Check Your Internet Connection or Try Again Later ${snapshot.error.toString()}',
              softWrap: true,
            ),
          );
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 290,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, index) {
                  var eachDetail = snapshot.data![index];
                  // appState.addproductAndButtonState(CardModel(
                  //     categoriesmodel: eachDetail, addedToCart: false));
                  return GestureDetector(
                    child: productCardDesign(context, eachDetail),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Productfulldescription()));
                    },
                  );
                }),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      });
}

Widget productCardDesign(BuildContext context, Categoriesmodel cat) {
  return Container(
    margin: const EdgeInsets.only(right: 15, bottom: 15),
    width: 160,
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          cat.imageUrl.toString(),
          width: 160,
          height: 160,
          //fit: BoxFit.cover,
        ),
        const SizedBox(
            // height: 14,
            ),
        cardProductDescription(
            context: context,
            product: cat,
            title: cat.title.toString(),
            price: cat.price.toString())
      ],
    ),
  );
}

// Widget cardProductDescription(String productName, double price) {
//   return Container(
//     //color: Colors.cyan,
//     child: Container(
//       //width: 90,
//       child: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   productName,
//                   // maxLines: 2,
//                   softWrap: true,
//                   style: const TextStyle(fontSize: 10),
//                   //textAlign: TextAlign.center,
//                 ),
//                 Text(
//                   "\$$price",
//                   style: TextStyle(
//                       fontSize: 14,
//                       color: neutral,
//                       fontWeight: FontWeight.bold),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 24,
//               width: 80,
//               child: Container(
//                 margin: EdgeInsets.only(right: 17),
//                 child: OutlinedButton(
//                   onPressed: () {},
//                   style: OutlinedButton.styleFrom(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(2.37)),
//                       side: const BorderSide(
//                           color: Color.fromRGBO(64, 140, 43, 1))),
//                   child: const Text(
//                     "Add",
//                     style: TextStyle(
//                       fontSize: 7,
//                       fontFamily: "PopppinsFont",
//                       color: Color.fromRGBO(64, 140, 43, 1),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ]),
//     ),
//   );
// }

Widget deals(String header) {
  return Container(
    margin: const EdgeInsets.only(top: 15),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              header,
              style: const TextStyle(fontSize: 18, fontFamily: "LoraFont"),
            ),
            const Text(
              "View all",
              style: TextStyle(fontSize: 14, fontFamily: "InterFont"),
            ),
          ],
        ),
        const Divider(
          height: 1,
          color: Color.fromRGBO(204, 203, 203, 1),
        ),
      ],
    ),
  );
}

Widget gridLayout(BuildContext context, Future<List<Categoriesmodel>> future,
    double height, double buttomPdadding, MainAppState state) {
  return FutureBuilder<List<Categoriesmodel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text(
            'Check Your Internet Connection or Try Again Later',
            softWrap: true,
          );
        } else if (snapshot.hasData) {
          ///add if statement
          return GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: buttomPdadding,
                  //childAspectRatio: 1 / 2,
                  mainAxisExtent: height
                  //childAspectRatio: MediaQuery.of(context).size.height / 1400,
                  // childAspectRatio: MediaQuery.of(context).size.width /
                  //     (MediaQuery.of(context).size.height),
                  ),
              padding: EdgeInsets.all(0),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, index) {
                return Container(
                    margin: const EdgeInsets.only(right: 15, bottom: 15),
                    height: 210,
                    width: 160,
                    //color: Colors.black,
                    child: Column(
                      children: [
                        Image.network(
                          snapshot.data![index].imageUrl.toString(),
                          width: 160,
                          height: 160,
                          //fit: BoxFit.cover,
                        ),
                        Column(children: [
                          cardProductDescription(
                              context: context,
                              product: snapshot.data![index],
                              title: snapshot.data![index].title.toString(),
                              price: snapshot.data![index].price.toString())
                        ])
                      ],
                    ));
              });
        } else {
          return const Center(child: Text('No data available'));
        }
      });
}

Widget collectionGridLayout(
    List images, List title, double height, double buttomPdadding) {
  return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: buttomPdadding,
          //childAspectRatio: 1 / 2,
          mainAxisExtent: height
          //childAspectRatio: MediaQuery.of(context).size.height / 1400,
          // childAspectRatio: MediaQuery.of(context).size.width /
          //     (MediaQuery.of(context).size.height),
          ),
      padding: EdgeInsets.all(0),
      itemCount: images.length,
      itemBuilder: (BuildContext context, index) {
        return Container(
            margin: const EdgeInsets.only(right: 15, bottom: 15),
            height: 210,
            width: 160,
            //color: Colors.black,
            child: Column(
              children: [
                Image.asset(
                  images[index],
                  height: 160,
                  width: 176,
                  fit: BoxFit.cover,
                ),
                Text(title[index])
              ],
            ));
      });
}

// Widget dealsGridChild(BuildContext context) {
//   return Column(
//     children: [
//       Image.asset(
//         "images/product1.png",
//         width: 160,
//         height: 160,
//         //fit: BoxFit.cover,
//       ),
//       Column(children: [cardProductDescription(context, "Title", "79")])
//     ],
//   );
// }

class cardProductDescription extends StatefulWidget {
  final BuildContext context;
  final Categoriesmodel product;
  final String title;
  final String price;

  const cardProductDescription(
      {super.key,
      required this.context,
      required this.product,
      required this.title,
      required this.price});

  @override
  State<cardProductDescription> createState() => _cartpro();
}

class _cartpro extends State<cardProductDescription> {
  late MainAppState state;
  late Widget button;
  late bool inCart;
  Color borderColor = Color.fromRGBO(64, 140, 43, 1);
  String text = "Add to cart";
  Color textColor = Color.fromRGBO(64, 140, 43, 1);
  Color backGround = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    state = Provider.of<MainAppState>(widget.context, listen: true);
    inCart = true;
  }

  void updateButtonToNotClicked() {
    setState(() {
      inCart = true;
      borderColor = Color.fromRGBO(64, 140, 43, 1);
      text = "Add to cart";
      backGround = Colors.white;
      print("teeds $inCart");
      textColor = Color.fromRGBO(64, 140, 43, 1);
      state.removeCartItem(widget.product);
      state.subtractCartSubTotal(double.parse(widget.price));
    });
  }

  void updateButtonToClicked() {
    setState(() {
      inCart = false;
      borderColor = Colors.white;
      text = "Added";
      backGround = Color.fromRGBO(64, 140, 43, 1);
      textColor = Colors.white;
      print("sasa$inCart");
      state.updateCartItems(widget.product);
      state.updateCartSubTotal(double.parse(widget.price));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(fontSize: 10),
            ),
            Text(
              "\$${widget.price}",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 24,
            //width: 80,
            child: Container(
                alignment: Alignment.bottomRight,
                //margin: EdgeInsets.only(right: 17),
                child: OutlinedButton(
                  onPressed: () {
                    if (inCart) {
                      updateButtonToClicked();
                      print(state.subTotal.toString());
                    } else {
                      updateButtonToNotClicked();
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: backGround,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      side: BorderSide(color: borderColor)),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 8.5,
                      fontFamily: "PopppinsFont",
                      color: textColor,
                    ),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}

// Widget cardProductDescription(
//     BuildContext context, Categoriesmodel product, String title, String price) {
//   Widget button;

//   var state = Provider.of<MainAppState>(context, listen: true);

//   switch (state.clicked) {
//     case false:
//       button = addToCart(context, state);
//       break;

//     case true:
//       button = addedbutton(state);
//       break;
//     default:
//       button = addToCart(context, state);
//   }

//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisSize: MainAxisSize.max,
//     children: [
//       Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: TextStyle(fontSize: 10),
//           ),
//           Text(
//             "\$$price",
//             style: TextStyle(
//               fontSize: 15,
//             ),
//           ),
//         ],
//       ),
//       Align(
//         alignment: Alignment.centerRight,
//         child: SizedBox(
//           height: 24,
//           //width: 80,
//           child: Container(
//               alignment: Alignment.bottomRight,
//               //margin: EdgeInsets.only(right: 17),
//               child: button),
//         ),
//       ),
//     ],
//   );
// }

// Widget addToCart(BuildContext context, MainAppState state) {
//   return OutlinedButton(
//     onPressed: () {
//       // state.updateCart(product);
//       //state.updateSubTotal(double.parse(product.price.toString()));
//       state.updateButton(true);
//       print(state.productAndButtonState.length);
//     },
//     style: OutlinedButton.styleFrom(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//         side: const BorderSide(color: Color.fromRGBO(64, 140, 43, 1))),
//     child: const Text(
//       "Add To Cart",
//       style: TextStyle(
//         fontSize: 8.5,
//         fontFamily: "PopppinsFont",
//         color: Color.fromRGBO(64, 140, 43, 1),
//       ),
//     ),
//   );
// }

// Widget addedbutton(MainAppState state) {
//   return OutlinedButton(
//     onPressed: () {
//       state.updateButton(false);
//       print(state.clicked);
//       // state.updateCart(product);
//       // state.updateSubTotal(double.parse(product.price.toString()));
//     },
//     style: OutlinedButton.styleFrom(
//         backgroundColor: Color.fromRGBO(64, 140, 43, 1),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//         side: const BorderSide(color: Colors.white)),
//     child: const Text(
//       "Added",
//       style: TextStyle(
//         fontSize: 8.5,
//         fontFamily: "PopppinsFont",
//         color: Colors.white,
//       ),
//     ),
//   );
// }

Widget collectionSection() {
  List<String> collectionImages = [
    "images/treat.png",
    "images/moisturize.png",
    "images/cleanse.png",
    "images/bodycare.png"
  ];
  List<String> collectionTitle = [
    "Treat & Nourish",
    "Moisturize & Protect",
    "Cleanse & Prep",
    "Body Care"
  ];
  return Column(
    children: [
      Container(
        alignment: Alignment.bottomLeft,
        margin: EdgeInsets.only(bottom: 8, top: 45),
        child: const Text(
          "Our Collection",
          style: TextStyle(
              fontSize: 16,
              fontFamily: "PopppinsFont",
              fontWeight: FontWeight.w300),
        ),
      ),
      Divider(
        //height: 1,
        color: Color.fromRGBO(204, 203, 203, 1),
      ),
      Container(
          margin: EdgeInsets.only(top: 24),
          child:
              collectionGridLayout(collectionImages, collectionTitle, 195, 10))
    ],
  );
}

Widget collectionGrid() {
  return Column(
    children: [
      Image.asset(
        "images/product1.png",
        height: 160,
        width: 176,
        fit: BoxFit.cover,
      ),
      Text("Cleanse & Prep")
    ],
  );
}
