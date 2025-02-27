import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/screen/personal_blogs_details_screen.dart';


import '../model/blogpostmodel.dart';

class PersonalBlogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
     
      body: Padding(
        padding: EdgeInsetsDirectional.only(top: 30),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('personalBlogs')
              .where('userId', isEqualTo: userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            var blogs = snapshot.data?.docs
                .map((doc) => BlogPost.fromMap(doc.data(), id: doc.id))
                .toList();
            return ListView.builder(
              itemCount: blogs?.length,
              itemBuilder: (context, index) {
                var blog = blogs![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            personalBlogsDetailsScreen(blog: blog),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.network(
                          blog.imageUrl,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            blog.title,
                            style: const TextStyle(
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
            );
          },
        ),
      ),
    );
  }
}














