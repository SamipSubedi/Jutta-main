import 'package:flutter/material.dart';
import 'package:shoesfyp2/screens/widgets/imageConstants.dart';

class Appicon extends StatelessWidget {
  final double height, width;
  Appicon({this.height, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage(
                ImagesConstants.appIcon,
              ))),
    );
  }
}
