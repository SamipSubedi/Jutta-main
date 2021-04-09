// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_form.dart';
// import 'package:flutter_credit_card/credit_card_model.dart';

// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:stripe_payment/stripe_payment.dart';

// class PaymentListBuilder extends StatefulWidget {
//   String id;
//   String price;
//   String plan;
//   String currency;
//   String country;
//   String unit;

//   PaymentListBuilder(
//       this.id, this.price, this.plan, this.currency, this.country, this.unit);

//   @override
//   _PaymentListBuilderState createState() => _PaymentListBuilderState();
// }

// final BankAccount bankAccount = BankAccount();

// class _PaymentListBuilderState extends State<PaymentListBuilder> {
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   // String stripeKey =
//   //     "pk_live_51I3zhxDfBKOkKmf9pQanRw4RfKboX29tP2OEXVJ1QqVJt1hMlHjGhLJenduRinDzSVwkl5ckYbHqaoNrtt6H1EqH00aztBA1Mg";
//   // String stripeKey =
//   // 'pk_test_51ICH4hLGXw4tTBHpZmqD3R9V4gOzGQTIcKy4kpqhGGHYLFIcHd3lwa3KFCIcribbRCFW829x7ZaKuBs6J4o5uJvA00jQxNsNcb';

//   // final CreditCard testCard = CreditCard(
//   //   number: '4111111111111111',
//   //   expMonth: 08,
//   //   expYear: 22,
//   // );

//   @override
//   initState() {
//     getStripeKey();

//     super.initState();
//   }

//   Future<void> getStripeKey() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String stripeKey = prefs.getString('stripe_key');
//     print("StripeKey:" + stripeKey);
//     StripePayment.setOptions(
//         StripeOptions(publishableKey: stripeKey, androidPayMode: 'test'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     void onCreditCardModelChange(CreditCardModel creditCardModel) {
//       setState(() {
//         cardNumber = creditCardModel.cardNumber;
//         expiryDate = creditCardModel.expiryDate;
//         cardHolderName = creditCardModel.cardHolderName;
//         cvvCode = creditCardModel.cvvCode;
//         isCvvFocused = creditCardModel.isCvvFocused;
//       });
//     }

//     Future<void> onPaymentSelected(
//         id, context, PaymentListBuilder builder, int value) async {
//       final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//       switch (value) {
//         case 0:
//           // StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
//           //     .then((paymentMethod) {})
//           //     .catchError((e) => print(e));
//           AwesomeDialog(
//             context: context,
//             dialogType: DialogType.NO_HEADER,
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   CreditCardForm(
//                     formKey: formKey,
//                     obscureCvv: true,
//                     onCreditCardModelChange: onCreditCardModelChange,
//                     obscureNumber: false,

//                     cardNumberDecoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Number',
//                       hintText: 'XXXX XXXX XXXX XXXX',
//                     ),

//                     expiryDateDecoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'Expired Date',
//                       hintText: 'XX/XX',
//                     ),
//                     cvvCodeDecoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'CVV',
//                       hintText: 'XXX',
//                     ),
//                     // cardHolderDecoration: const InputDecoration(
//                     //   border: OutlineInputBorder(),
//                     //   labelText: 'Card Holder',
//                     // ),
//                     // onCreditCardModelChange: onCreditCardModelChange,
//                   ),
//                   RaisedButton(
//                     child: Text(
//                       'PAY',
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                     color: secondary,
//                     onPressed: () {
//                       print(expiryDate);
//                       print(
//                           "${expiryDate.substring(0, 2)} ${expiryDate.substring(3, 5)}");
//                       final CreditCard testCard = CreditCard(
//                           number: cardNumber,
//                           expMonth: int.parse("${expiryDate.substring(0, 2)}"),
//                           cvc: cvvCode.toString(),
//                           expYear: int.parse("${expiryDate.substring(3, 5)}"));
//                       showDialog(
//                           builder: (context) => Dialog(
//                                 child: LinearProgressIndicator(
//                                   valueColor:
//                                       AlwaysStoppedAnimation(Colors.black),
//                                   minHeight: 5,
//                                   backgroundColor:
//                                       Colors.black.withOpacity(0.5),
//                                 ),
//                               ),
//                           context: context,
//                           barrierDismissible: false);
//                       StripePayment.createTokenWithCard(testCard).then((token) {
//                         print(token.tokenId);
// // /payment
//                         Network().paymentWithCard(context, id, token.tokenId);

//                         // createCharge(token.tokenId);
//                       }).catchError((err) {
//                         Navigator.pop(context);
//                         AwesomeDialog(
//                           context: context,
//                           dialogType: DialogType.ERROR,
//                           animType: AnimType.BOTTOMSLIDE,
//                           title: 'Error!',
//                           body: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Center(
//                               child: Text(
//                                 err.toString(),
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         )..show();
//                       });
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ).show();

//           //     .catchError((e) {
//           //   print('ERROR ${e.toString()}');
//           // }).then((PaymentMethod paymentMethod) async {
//           //   final CreditCard testCard = CreditCard(
//           //       number: paymentMethod.card.number,
//           //       expMonth: paymentMethod.card.expMonth,
//           //       expYear: paymentMethod.card.expYear);

//           //   // StripePayment.createTokenWithCard(testCard).then((token) {
//           //   //   print(token.tokenId);
//           //   // });
//           // });
//           break;
//         case 1:
//           StripePayment.createTokenWithBankAccount(
//             bankAccount,
//           ).then((token) {}).catchError((e) => print(e));
//           break;
//         case 2:
//           try {
//             print(builder.price);
//             final token = await StripePayment.paymentRequestWithNativePay(
//               androidPayOptions: AndroidPayPaymentRequest(
//                 totalPrice: builder.price,
//                 currencyCode: builder.currency,
//               ),
//               applePayOptions: ApplePayPaymentOptions(
//                 countryCode: 'AU',
//                 currencyCode: builder.currency,
//                 items: [
//                   ApplePayItem(
//                     label: builder.plan,
//                     amount: builder.price,
//                   )
//                 ],
//               ),
//             );
//             print("stripe_token: ${token.tokenId}");
//             //todo send token to server
//           } catch (e) {
//             print(e);
//           }
//           ;
//           break;
//       }
//     }

//     PaymentListBuilder builder = PaymentListBuilder(widget.id, widget.price,
//         widget.plan, widget.currency, widget.country, widget.unit);
//     return Card(
//       shadowColor: Colors.black,
//       elevation: 5,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25.0),
//         child: Column(
//           // crossAxisAlignment: CrossAxisAlignment.end,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   widget.plan,
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                 ),
//                 Text(
//                   "${widget.currency} ${widget.price}",
//                   textAlign: TextAlign.end,
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "credit points: ${widget.unit}",
//                   style: TextStyle(
//                       fontWeight: FontWeight.normal,
//                       fontSize: 18,
//                       fontStyle: FontStyle.italic),
//                 ),
//                 RaisedButton(
//                   color: primary,
//                   onPressed: () =>
//                       onPaymentSelected(widget.id, context, builder, 0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                   ),
//                   child: Text(
//                     "buy",
//                     textAlign: TextAlign.end,
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 22),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void onListItemClick(context) {
//   showDialog(
//     context: context,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text(
//           'Select Payment',
//           style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//         ),
//         content: setupAlertDialogContainer(),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Approve'),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//         ],
//       );
//     },
//   );
// }

// Widget setupAlertDialogContainer() {
//   List<String> payments = [
//     "Credit Card",
//     "Bank Account",
//     Platform.isAndroid ? "Google Pay" : "Apple Pay"
//   ];

//   return Container(
//     width: 300.0,
//     height: 200.0,
//     child: ListView.separated(
//         separatorBuilder: (BuildContext context, int index) => const Divider(
//               thickness: 2,
//               height: 10,
//             ),
//         shrinkWrap: true,
//         itemCount: payments.length,
//         itemBuilder: (context, i) {
//           return InkWell(
//             // onTap: () => onPaymentSelected(i),
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
//               child: Text(
//                 payments[i],
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.normal),
//               ),
//             ),
//           );
//         }),
//   );
// }
