import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled/tools/drawer.dart';

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
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height *0.09,
        iconTheme: const IconThemeData(color:Colors.grey),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('image/logo.jpg', fit: BoxFit.fitHeight, height: 55),
        actions: [
          GestureDetector(
            onTap:() {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()));
              },
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015)),
              Icon(Icons.book_outlined, size: MediaQuery.of(context).size.height * 0.035),
              Text('   App\nManual',style: TextStyle(color: Colors.black54, fontSize: 10),)]),),
          Padding(padding:EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.055))],

      ),
        drawer: DrawerForAll(),
        body: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left:15, top:5),
                child: Text('Introduction', style: TextStyle(fontSize: 20, fontFamily: 'MontserratExtraBold')),
              ),

              Padding(
                padding: EdgeInsets.only(left:15, top:20, bottom: 15),
                child: Text('Welcome To 22VZ App', style: TextStyle(fontSize: 50, fontFamily: 'MontserratExtraBold', color: Color.fromRGBO(0, 62, 70, 0.7))),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
              child: Image.asset('image/unkoreaflag.jpeg'),
              ),

              Padding(padding:EdgeInsets.only(bottom:30)),
              Divider(color: Colors.black, thickness: 2, ),

              Padding(
                padding: EdgeInsets.only(left:15),
                child: Text('Latest News', style: TextStyle(fontSize: 20, fontFamily: 'MontserratExtraBold')),
              ),

              Padding(
                padding:EdgeInsets.only(bottom: 30)
              ),


                  StreamBuilder<QuerySnapshot>(
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
                            });
                      })
              ]
        ));
  }
}
