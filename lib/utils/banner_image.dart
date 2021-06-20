import 'package:flutter/material.dart';

class BannerImage extends StatelessWidget {
  String imagePath;
  BannerImage({@required this.imagePath});
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),),
        child: Image(
          width: MediaQuery.of(context).size.width,
        image: AssetImage(imagePath),
        fit: BoxFit.fill,
      ),
    );
  }
}

