import 'package:flutter/material.dart';

class AddBlog extends StatefulWidget {
  const AddBlog({Key? key}) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
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
              Container(
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_a_photo),
                  ),
                ),
                color: Colors.white,
                width: double.infinity,
                height: 200,
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'AuthorName',
                    ),
                  ),
                  TextFormField(
                    style: TextStyle(
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
