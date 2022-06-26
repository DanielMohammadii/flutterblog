import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  final TextEditingController authNamecontroller = TextEditingController();
  final TextEditingController titlcontroller = TextEditingController();
  final TextEditingController blogcontroller = TextEditingController();

  @override
  void dispose() {
    authNamecontroller.dispose();
    titlcontroller.dispose();
    blogcontroller.dispose();
    super.dispose();
  }

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

  Future uploaddata() async {
    final String fileName = path.basename(image!.path);
    final storageRef = FirebaseStorage.instance;
    final db = FirebaseFirestore.instance;
    Reference ref = storageRef.ref().child('images/$fileName');
    await ref.putFile(File(image!.path));
    var imgUrl = await ref.getDownloadURL();

    Map<String, dynamic> user = {
      'imgUrl': imgUrl,
      'name': authNamecontroller.text,
      'title': titlcontroller.text,
      'blog': blogcontroller.text,
    };

    db.collection('users').doc().set(user);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 77, 70, 70),
        elevation: 0,
        title: const Text('Flutter Blog'),
      ),
      backgroundColor: const Color.fromARGB(255, 112, 105, 105),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              image != null
                  ? Stack(
                      children: [
                        SizedBox(
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
                            icon: const Icon(
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
                          icon: const Icon(Icons.add_a_photo),
                        ),
                      ),
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                    ),
              const SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  TextFormField(
                    controller: authNamecontroller,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'AuthorName',
                    ),
                  ),
                  TextFormField(
                    controller: titlcontroller,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Title',
                    ),
                  ),
                  TextFormField(
                    controller: blogcontroller,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Blog',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      uploaddata();
                    },
                    child: const Text('Upload to Storag'),
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
