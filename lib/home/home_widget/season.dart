import 'package:flutter/material.dart';

class MyStack extends StatelessWidget {
  final String url, text;
  const MyStack({required this.url, required this.text});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(
          url,
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        Text(text, style: TextStyle(color: Colors.white, fontSize: 30)),
      ],
    );
  }
}
