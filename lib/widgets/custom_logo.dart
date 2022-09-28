import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  final AssetImage image;
  final String text;

  const CustomLogo({
    Key? key, 
    required this.image, 
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: 170,
        child: Column(children: [
          Image(image: this.image),
          SizedBox(height: 20),
          Text(this.text, style: TextStyle(fontSize: 30),
          )
        ]),
      ),
    );
  }
}
