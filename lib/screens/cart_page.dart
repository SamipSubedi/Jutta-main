import 'package:auto_size_text/auto_size_text.dart';
import 'package:shoesfyp2/network/cart_model.dart';
import 'package:shoesfyp2/screens/product_page.dart';
import 'package:shoesfyp2/services/firebase_services.dart';
import 'package:shoesfyp2/widgets/custom_action_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';
import '../network/network.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartList(_firebaseServices.getUserId());
    String stripeKey =
        "pk_test_51IeKCzAAFPfMtoIQu5gfX9GbRBL5oyyDeue2Xp5Dp75D0ido7e8NZn8ROFot7vuzlWa6DY3oDkedCKIKAeYoYIZh00jCeqBicM";
    print("StripeKey:" + stripeKey);
    StripePayment.setOptions(
      StripeOptions(
          publishableKey: stripeKey,
          androidPayMode: 'live',
          merchantId:
              "sk_test_51IeKCzAAFPfMtoIQT2ao7buSEQZ7wcTB8sefSNh6yMeXQXatqEe8VGM0TZrMFCStEkBxOi5mEydXYWt4ADdyYjwG009ckumuTw"),
    );
  }

  payWithStripe() {
    // StripePayment.paymentRequestWithCardForm(
    //   CardFormPaymentRequest(),

    StripePayment.paymentRequestWithNativePay(
      applePayOptions: ApplePayPaymentOptions(
        countryCode: 'DE',
        currencyCode: 'EUR',
        items: [
          ApplePayItem(
            label: 'Test',
            amount: '27',
          )
        ],
      ),
      androidPayOptions: AndroidPayPaymentRequest(
        totalPrice: "200",
        currencyCode: "AUD",
      ),
    ).then((paymentMethod) {
      print(paymentMethod);
      setState(() {
        // _paymentMethod = paymentMethod;
      });
    }).catchError(() {
      print("error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: getCartList(_firebaseServices.getUserId()),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // Collection Data ready to display
              if (snapshot.hasData) {
                // Display the data inside a list view
                List<CartModel> responsedata = snapshot.data;
                return ListView.builder(
                  padding: EdgeInsets.only(
                    top: 108.0,
                    bottom: 12.0,
                  ),
                  itemCount: responsedata.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 24.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                "${responsedata[i].imageUrl}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              left: 16.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 200,
                                  child: AutoSizeText(
                                    "${responsedata[i].name}",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: Text(
                                    "\$${responsedata[i].price}",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Text(
                                  "Size - ${responsedata[i].shoe_size}",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
          CustomActionBar(
            hasBackArrrow: true,
            title: "Cart",
          ),
          InkWell(
            onTap: () {
              payWithStripe();
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(20.0),
              color: Colors.black,
              height: 100,
              child: Center(
                child: Text(
                  "Purchase",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
