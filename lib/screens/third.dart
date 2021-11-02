import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'anv.dart';
import 'home.dart';

class Second extends StatefulWidget {
  const Second({Key? key}) : super(key: key);

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  final Stream<QuerySnapshot> adv = FirebaseFirestore.instance.collection('ArticlesAndVideo').snapshots();


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: ListView(
        children: <Widget>[
                              Row(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.only(left:30, top: 10)),
                                Text('A', style: TextStyle(fontSize: 40)),
                              ]
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
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),),
                                color: Colors.white,
                                elevation: 10,
                                child: GridTile(
                                  child: Container(
                                    padding: EdgeInsets.only(top: 20,
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
                                                        fontSize: 30,),
                                                      textAlign: TextAlign.left,
                                                    ),),
                                                ),
                                              ]
                                          )
                                      ),),),
                                ),);
                            });
                      })
    )]
    ));
  }
}