import 'dart:convert';

import 'package:rating_bar/rating_bar.dart';
import 'package:shoesfyp2/constants.dart';
import 'package:shoesfyp2/network/network.dart';
import 'package:shoesfyp2/network/shoes_model.dart';
import 'package:shoesfyp2/services/firebase_services.dart';
import 'package:shoesfyp2/widgets/custom_action_bar.dart';
import 'package:shoesfyp2/widgets/image_swipe.dart';
import 'package:shoesfyp2/widgets/product_size.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//class ProductPage extends StatefulWidget {
//final String productId;
//ProductPage({this.productId});
/*   @override
  _ProductPageState createState() => _ProductPageState();}
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices(); */
class ProductPage extends StatefulWidget {
  final String productId;
  final ShoesModel productJsonData;
  ProductPage({this.productId, this.productJsonData});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _selectedProductSize = "0";

  Future _addToCart() {
/*     return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .doc(widget.productId)
        .set({"size": _selectedProductSize}); */
    addtoCart(widget.productJsonData.id, _firebaseServices.getUserId());
  }

  Future _addToSaved() {
    // return _firebaseServices.usersRef
    //     .doc(_firebaseServices.getUserId())
    //     .collection("Saved")
    //     .doc(widget.productId)
    //     .set({"size": _selectedProductSize});
    addtoSave(widget.productJsonData.id, _firebaseServices.getUserId());
  }

  final SnackBar _snackBar = SnackBar(
    content: Text("Product added"),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Scaffold(
            body: FutureBuilder(
              //future: _firebaseServices.productsRef.doc(widget.productId).get(),
              //builder: (context, snapshot) {
              future: getShoesList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // Firebase Document Data Map
                  // Map<String, dynamic> documentData = snapshot.data.data();

                  // // List of images
                  // List imageList = documentData['images'];
                  // List productSizes = documentData['size'];

                  // Set an initial size
                  // _selectedProductSize = productSizes[0];
//
                  return ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      ImageSwipe(
                        imageList: [
                          widget.productJsonData.imageUrl,
                          widget.productJsonData.imageUrl,
                          widget.productJsonData.imageUrl,
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24.0,
                          left: 24.0,
                          right: 24.0,
                          bottom: 4.0,
                        ),
                        child: Text(
                          "${widget.productJsonData.name}",
                          style: Constants.boldHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "People also buy - ${widget.productJsonData.items}",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "\$${widget.productJsonData.price}",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "${widget.productJsonData.description}",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          "Select Size",
                          style: Constants.regularDarkText,
                        ),
                      ),
                      ProductSize(
                        productSizes: json.decode(widget.productJsonData.size),
                        onSelected: (size) {
                          _selectedProductSize = size;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 24.0,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "Rating :",
                              style: Constants.regularDarkText,
                            ),
                            RatingBar.readOnly(
                              initialRating:
                                  double.parse(widget.productJsonData.rating),
                              isHalfAllowed: true,
                              halfFilledIcon: Icons.star_half,
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await _addToSaved();
                                Scaffold.of(context).showSnackBar(_snackBar);
                              },
                              child: Container(
                                width: 65.0,
                                height: 65.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFFDCDCDC),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                alignment: Alignment.center,
                                child: Image(
                                  image: AssetImage(
                                    "assets/images/tab_saved.png",
                                  ),
                                  height: 22.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () async {
                                  await _addToCart();
                                  Scaffold.of(context).showSnackBar(_snackBar);
                                },
                                child: Container(
                                  height: 65.0,
                                  margin: EdgeInsets.only(
                                    left: 16.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Add To Cart",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }

                // Loading State
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
          CustomActionBar(
            hasBackArrrow: true,
            hasTitle: false,
            hasBackground: false,
          )
        ],
      ),
    );
  }
}
