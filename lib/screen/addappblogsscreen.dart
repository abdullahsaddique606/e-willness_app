import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

class AddAppBlogScreen extends StatefulWidget {
  @override
  _AddAppBlogScreenState createState() => _AddAppBlogScreenState();
}

class _AddAppBlogScreenState extends State<AddAppBlogScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;
  File? _image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<String> uploadFile(File file) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('blog_images/${DateTime.now().toString()}');
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  void _saveBlog() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_image != null) {
        String imageUrl = await uploadFile(_image!);

        await FirebaseFirestore.instance
            .collection('personalBlogs')
            .add({
          'title': _title,
          'description': _description,
          'imageUrl': imageUrl,
          'userId': FirebaseAuth.instance.currentUser?.uid,
        });

        Fluttertoast.showToast(msg: "Blog saved successfully!");

        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: "Please select an image.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Blog')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Title is required' : null,
                onSaved: (value) => _title = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Description is required' : null,
                onSaved: (value) => _description = value,
              ),
              SizedBox(height: 20),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(_image!, height: 300, width: double.infinity),
              IconButton(
                icon: Icon(Icons.add_a_photo),
                onPressed: getImage,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveBlog,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
