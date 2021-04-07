import 'package:flutter/material.dart';
import 'package:shoesfyp2/screens/widgets/colors.dart';

class Mainbackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColor.darkBluefirst, AppColor.darkBluesecond])),
    );
  }
}
