import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/appblogs_viewmmodel.dart';
import 'blogsdetailsscreen.dart';


class AppBlogsScreen extends StatelessWidget {


  AppBlogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppBlogsViewModel>(builder: (context, viewModel, _) {
      return Scaffold(
        body: ListView.builder(
          itemCount: viewModel.appBlogs.length,
          itemBuilder: (context, index) {
            final blog = viewModel.appBlogs[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogDetailScreen(blog: blog),
                  ),
                );
              },
              child: Card(
                elevation: 2,
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Image.asset(
                      blog.image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        blog.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}