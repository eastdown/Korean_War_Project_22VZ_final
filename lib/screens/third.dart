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
                  return GridTile(
                      child: Container(
                        padding: EdgeInsets.only( bottom:20, top: 20),
                        child: SizedBox(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AnvPage()));
                                currentIndex = index;
                                },
                              child: Column(
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(right:10, left: 10, bottom:10),
                                        child: Image.network('${snapshot.data!.docs[index]['image']}', fit: BoxFit.fitWidth,)),
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
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 15,),
                                      child: Align(
                                        alignment: Alignment
                                            .centerLeft,
                                        child: Text(snapshot.data!
                                            .docs[index]['subexplanation'],
                                          style: TextStyle(
                                              fontSize: 20, fontFamily: 'MontserratRegular'),
                                          textAlign: TextAlign.left,
                                        ),),
                                    ),
                                    Divider(color: Colors.black54),
                                  ]
                              )
                          ),),),
);
},
);
}
)
);
}}
