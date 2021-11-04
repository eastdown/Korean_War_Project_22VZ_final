import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'anv.dart';

late int currentIndex;

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
        body: ListView(
            children: <Widget>[
              Divider(color: Colors.black, thickness: 3, ),
              Padding(
                padding: EdgeInsets.only(left:15),
                child: Text('Introduction', style: TextStyle(fontSize: 20, fontFamily: 'MontserratExtraBold')),
              ),

              Padding(
                padding: EdgeInsets.only(left:15, bottom: 30, top:20),
                child: Text('Welcome To 22VZ App', style: TextStyle(fontSize: 65, fontFamily: 'MontserratExtraBold', color: Color.fromRGBO(0, 62, 70, 0.7))),
              ),

              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: SizedBox(
                    height: 50,
                    width: 200,
                    child: OutlinedButton(onPressed: () {  },
                        child: Text('Learn about 22VZ', style: TextStyle(fontSize: 20, color: Colors.black), )
                    ),),)
              ]),

              Padding(padding:EdgeInsets.only(bottom:10)),
              Divider(color: Colors.black, thickness: 3, ),

              Padding(
                padding: EdgeInsets.only(left:15),
                child: Text('Latest News', style: TextStyle(fontSize: 20, fontFamily: 'MontserratExtraBold')),
              ),

              Padding(
                padding:EdgeInsets.only(bottom: 30)
              ),

              Flexible(
                  child:StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('ArticlesAndVideo').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Divider(height: 1, thickness: 1);
                        }
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return GridTile(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        bottom: 20),
                                    child: SizedBox(
                                      child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AnvPage()));
                                            currentIndex = index;
                                          },
                                          child: Column(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 10,
                                                      left: 10,
                                                      bottom: 10),
                                                  child: Image.network(
                                                      '${snapshot.data!
                                                          .docs[index]['image']}'),),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    left: 10,),
                                                  child: Align(
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: Text(snapshot.data!
                                                        .docs[index]['title'],
                                                      style: TextStyle(
                                                        fontSize: 30, fontFamily: 'MontserratExtraBold'),
                                                      textAlign: TextAlign.left,
                                                    ),),
                                                ),
                                                Divider(color: Colors.black54),
                                              ]
                                          )
                                      ),),),
                                );
                            });
                      })
              )]
        ));
  }
}
