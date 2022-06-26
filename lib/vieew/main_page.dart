import 'package:addttofirestore/vieew/add_blog.dart';
import 'package:addttofirestore/vieew/detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final CollectionReference _firestoreRef =
      FirebaseFirestore.instance.collection('users');

  mainToDetail(DocumentSnapshot post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(post: post)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 24, 11),
      appBar: AppBar(
        title: Text('BlogPosts'),
        backgroundColor: Color.fromARGB(255, 5, 41, 24),
      ),
      body: StreamBuilder(
        stream: _firestoreRef.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasError) {
            return const Text('has error somewhere');
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: ((context, index) {
              final DocumentSnapshot documentSnapshot =
                  streamSnapshot.data!.docs[index];
              return Container(
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => mainToDetail(streamSnapshot.data!.docs[index]),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            documentSnapshot['imgUrl'],
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                        Container(
                          height: 180,
                          color: Colors.black45.withOpacity(.3),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                documentSnapshot['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                documentSnapshot['name'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                documentSnapshot['blog'],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBlog()),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
