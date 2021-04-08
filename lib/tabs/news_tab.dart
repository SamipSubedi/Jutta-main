import 'package:shoesfyp2/constants.dart';
import 'package:shoesfyp2/network/network.dart';
import 'package:shoesfyp2/network/news_model.dart';
import 'package:shoesfyp2/services/firebase_services.dart';
import 'package:shoesfyp2/widgets/custom_action_bar.dart';
import 'package:shoesfyp2/widgets/custom_input.dart';
import 'package:shoesfyp2/widgets/news_card.dart';
import 'package:shoesfyp2/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewsTab extends StatefulWidget {
  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            child: FutureBuilder(
              future: getNewsList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<NewsModel> data = snapshot.data;
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return NewsCard(
                          title: data[index].name,
                          newsId: data[index].id.toString(),
                          imageUrl: data[index].imageUrl,
                          description: data[index].description,
                          newsJsonData: data[index]);
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          // Loading State

          CustomActionBar(
            title: "NEWS",
            hasBackArrrow: false,
          ),
        ],
      ),
    );
  }
}