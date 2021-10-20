import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final Stream<QuerySnapshot> adv = FirebaseFirestore.instance.collection('ArticlesAndVideo').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ArticlesAndVideo').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData){
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                color: Colors.white,
                elevation: 10,
                child: GridTile(
                  child: Container(
                    padding: EdgeInsets.only(top:20, bottom:20),
                    child: SizedBox(
                      child: GestureDetector(
                        onTap: () {

                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right:10, left: 10, bottom:10),
                            child: Image.network('${snapshot.data!.docs[index]['image']}'),),
                            Container(
                              padding: EdgeInsets.only(left:10,),
                              child: Align(
                              alignment: Alignment.centerLeft,
                            child: Text(snapshot.data!.docs[index]['title'],
                            style: TextStyle(
                              fontSize: 30,),
                              textAlign: TextAlign.left,
                            ),),
                            ),
                          ]
                        )
                      ),),),
                ),);
            },
        );
    }
        )
      );
  }}
