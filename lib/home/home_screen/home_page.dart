import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task4/first_screen.dart';

import '../../profile/profile_page/profile_page.dart';
import '../home_widget/home_widget.dart';

class MyHomePage extends StatelessWidget {
  final String? Title;
  final String? Body;
  final List<File>? image;

  const MyHomePage({this.image, this.Body, this.Title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            icon: Icon(Icons.account_box),
          ),
        ],
        centerTitle: true,
        title: Text(Title ?? "Tree"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            image == null || image!.isEmpty
                ? Image.asset("assets/Tree.jpg")
                : Image.file(
                  image![0],
                  height: 300,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.share)),

                Favoritewidget(),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.justify,
                Body ??
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
              ),
            ),

            image == null || image!.isEmpty
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: [
                    MyStack(url: "assets/TreeFall.jpg", text: "Fall"),
                    MyStack(url: "assets/TreeSpring.jpg", text: "Spring"),
                  ],
                )
                : SizedBox(
                  height: 500,
                  child: GridView.builder(
                    itemCount: image!.length,
                    itemBuilder:
                        (context, index) => Image.file(
                          image![index],
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 10,
                      crossAxisSpacing: 10,
                    ),
                  ),
                ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FirstScreen()),
          );
        },
        child: Icon(Icons.next_plan),
      ),
    );
  }
}
