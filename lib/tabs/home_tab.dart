import 'package:shoesfyp2/network/network.dart';
import 'package:shoesfyp2/network/shoes_model.dart';
import 'package:shoesfyp2/widgets/custom_action_bar.dart';
import 'package:shoesfyp2/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            child: FutureBuilder(
              future: getShoesList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ShoesModel> data = snapshot.data;
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ProductCard(
                          title: data[index].name,
                          productId: data[index].id.toString(),
                          imageUrl: data[index].imageUrl,
                          price: data[index].price.toString(),
                          productJsonData: data[index]);
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
          // Loading State

          CustomActionBar(
            title: "Home",
            hasBackArrrow: false,
          ),
        ],
      ),
    );
  }
}
