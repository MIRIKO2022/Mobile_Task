import 'package:flutter/material.dart';

class Favoritewidget extends StatefulWidget {
  const Favoritewidget({super.key});

  @override
  State<Favoritewidget> createState() => _FavoritewidgetState();
}

class _FavoritewidgetState extends State<Favoritewidget> {
  bool click = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          click = !click;
        });
      },
      icon: Icon(Icons.favorite, color: click ? Colors.red : Colors.black),
    );
  }
}
