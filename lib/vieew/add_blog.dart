import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  File? image;
  Future imagePick() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    setState(() {
      this.image = imageTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 77, 70, 70),
        elevation: 0,
        title: Text('Flutter Blog'),
      ),
      backgroundColor: Color.fromARGB(255, 112, 105, 105),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              image != null
                  ? Stack(
                      children: [
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Center(
                          child: IconButton(
                            onPressed: () {
                              imagePick();
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            imagePick();
                          },
                          icon: Icon(Icons.add_a_photo),
                        ),
                      ),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                    ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'AuthorName',
                    ),
                  ),
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Title',
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Blog',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
