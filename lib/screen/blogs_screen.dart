import 'package:flutter/material.dart';
import 'package:myproject/screen/personalblogsscreen.dart';

import 'addappblogsscreen.dart';
import 'appblogsscreen.dart';


class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  bool isAppBlogsSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Blogs')),
      ),
      body: isAppBlogsSelected ?  AppBlogsScreen() : PersonalBlogsScreen(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ToggleButtons(
          isSelected: [isAppBlogsSelected, !isAppBlogsSelected],
          onPressed: (index) {
            setState(() {
              isAppBlogsSelected = index == 0;
            });
          },
          borderRadius: BorderRadius.circular(8.0),
          selectedBorderColor: Colors.blue,
          selectedColor: Colors.white,
          fillColor: Colors.blue,
          color: Colors.blue,
          constraints: BoxConstraints(
            minHeight: 50.0,
            minWidth: MediaQuery.of(context).size.width / 2 - 24,
          ),
          children: const <Widget>[
             Text('App Blogs', style: TextStyle(fontSize: 18)),
             Text('Personal Blogs', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
      floatingActionButton: isAppBlogsSelected
          ? null
          : FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAppBlogScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
