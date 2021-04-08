import 'package:shoesfyp2/constants.dart';
import 'package:shoesfyp2/network/news_model.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class NewsCard extends StatelessWidget {
  final String newsId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String description;
  final NewsModel newsJsonData;

  NewsCard(
      {this.onPressed,
      this.imageUrl,
      this.title,
      this.newsId,
      this.description,
      this.newsJsonData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 24.0,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                "$imageUrl",
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: AutoSizeText(
                      "Brand - " + title,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: AutoSizeText(
                      description,
                      style: Constants.normal,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
