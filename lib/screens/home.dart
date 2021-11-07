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
              //Divider(color: Colors.black, thickness: 3, ),
              Padding(
                padding: EdgeInsets.only(left:15, top:10),
                child: Text('Introduction', style: TextStyle(fontSize: 20, fontFamily: 'MontserratExtraBold')),
              ),

              Padding(
                padding: EdgeInsets.only(left:15, bottom: 30, top:20),
                child: Text('Welcome To 22VZ App', style: TextStyle(fontSize: 65, fontFamily: 'MontserratExtraBold', color: Color.fromRGBO(0, 62, 70, 0.7))),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                margin: EdgeInsets.only(left: 10, right: 10),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(
                            iconTheme: const IconThemeData(color: Colors.grey),
                           backgroundColor: Colors.white,
                            title: Text('About Us', style: TextStyle(color: Colors.black, fontFamily: 'MontserratExtraBold'),),
                          ),
                          body: Scaffold(
                              body: SingleChildScrollView(
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(),
                                  child: Column(
                                      children: <Widget> [
                                        Padding (
                                          padding: EdgeInsets.only(left:10, right: 10),
                                          child: Image.asset('image/groupA.jpg'),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left:10, right:10, top:20),
                                            child: Text('Who We Are', style: TextStyle(fontSize: 50, fontFamily: 'MontserratExtraBold', ))
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left:20, right: 40, top:20),
                                            child: Text('    We are a youth organization that strives to connect, communicate, and show gratitude to the Korean War Veterans.',
                                                style: TextStyle(fontSize: 20, fontFamily: 'MontserratRegular'))
                                        ),

                                        Padding(
                                            padding: EdgeInsets.only(left:10, top: 30, right:10),
                                            child: Text('What We Do', style: TextStyle(fontSize: 50, fontFamily: 'MontserratExtraBold',))
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(left:20, right: 40, top:20),
                                            child: Text('    Our goal is to show how current-day Korea has changed since the Korean War. We post videos, write articles, and conduct research on the history of the war to connect with the youth, who do not know much, and to remember the services of the veterans. \n \n    The name of our organization is 22VZ. 22 is for the 16 countries that fought in the war and the 6 countries that provided aid, V is for veterans, and Z is for the Z generation (the current generation of youths). Our name comes from our mission to connect the youth of the present with the events of the past. \n \n    But that is not what we only do. Another goal of ours is to give back to the veterans who have served in the war. There are many of them who are poor and in need of aid. We hope to raise a charity for them to meet their needs and show appreciation for their service.',
                                                style: TextStyle(fontSize: 20, fontFamily: 'MontserratRegular'))
                                        ),

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child:Padding(
                                            padding: EdgeInsets.only(bottom: 20, top:10, left: 10),
                                            child: Text(
                                              'Leaders',
                                              style: TextStyle(fontSize: 50, fontFamily:'MontserratExtraBold'),
                                            ),),),
                                        SizedBox(
                                          height: 400.0,
                                          child: ListView(
                                              physics: ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              children: <Widget> [
                                                Card(
                                                  semanticContainer: true,
                                                  child: Stack(
                                                      children: <Widget>[
                                                        Image.asset('image/Dongha.jpg'),
                                                        Padding(padding: EdgeInsets.only(left:20),
                                                            child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom:300),
                                                                  ),

                                                                  Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Text('Dongha Kim', style: TextStyle(fontSize: 30, fontFamily:'MontserratExtraBold', color: Colors.white,
                                                                      shadows: <Shadow>[

                                                                        Shadow(
                                                                          offset: Offset(0, 0),
                                                                          blurRadius: 15.0,
                                                                          color: Color.fromRGBO(0, 0, 70, 0.8),
                                                                        ),
                                                                      ],)),),


                                                                  Text('App Leader/Founder', style: TextStyle(fontSize: 20, fontFamily:'MontserratExtraBold', color: Colors.white,
                                                                    shadows: <Shadow>[

                                                                      Shadow(
                                                                        offset: Offset(0, 0),
                                                                        blurRadius: 15.0,
                                                                        color: Color.fromRGBO(0, 0, 70, 0.8),
                                                                      ),
                                                                    ],)
                                                                  ),
                                                                ]
                                                            ))
                                                      ]
                                                  ),),

                                                Card(
                                                  semanticContainer: true,
                                                  child: Stack(
                                                      children: <Widget>[
                                                        Image.asset('image/Amber.jpg'),
                                                        Column(
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: EdgeInsets.only(bottom:300),
                                                              ),
                                                              Padding(
                                                                  padding: EdgeInsets.only(left:20),
                                                                  child: Text('Amber Kim', style: TextStyle(fontSize: 30, fontFamily:'MontserratExtraBold', color: Colors.white,
                                                                    shadows: <Shadow>[

                                                                      Shadow(
                                                                        offset: Offset(0, 0),
                                                                        blurRadius: 15.0,
                                                                        color: Color.fromRGBO(0, 0, 70, 0.8),
                                                                      ),
                                                                    ],))
                                                              ),

                                                              Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Text('Writing Leader', style: TextStyle(fontSize: 20, fontFamily:'MontserratExtraBold', color: Colors.white,
                                                                  shadows: <Shadow>[

                                                                    Shadow(
                                                                      offset: Offset(0, 0),
                                                                      blurRadius: 15.0,
                                                                      color: Color.fromRGBO(0, 0, 70, 0.8),
                                                                    ),
                                                                  ],)
                                                                ),
                                                              )
                                                            ]
                                                        )
                                                      ]
                                                  ),),

                                                Card(
                                                  semanticContainer: true,
                                                  child: Stack(
                                                      children: <Widget>[
                                                        Image.asset('image/Joshua.jpg'),
                                                        Padding(padding: EdgeInsets.only(left:20),
                                                            child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom:300),
                                                                  ),

                                                                  Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Text('Joshua Kim', style: TextStyle(fontSize: 30, fontFamily:'MontserratExtraBold', color: Colors.white,
                                                                      shadows: <Shadow>[

                                                                        Shadow(
                                                                          offset: Offset(0, 0),
                                                                          blurRadius: 15.0,
                                                                          color: Color.fromRGBO(0, 0, 70, 0.8),
                                                                        ),
                                                                      ],)),),


                                                                  Text('Communication Leader', style: TextStyle(fontSize: 20, fontFamily:'MontserratExtraBold', color: Colors.white,
                                                                    shadows: <Shadow>[

                                                                      Shadow(
                                                                        offset: Offset(0, 0),
                                                                        blurRadius: 15.0,
                                                                        color: Color.fromRGBO(0, 0, 70, 0.8),
                                                                      ),
                                                                    ],)
                                                                  ),
                                                                ]
                                                            ))
                                                      ]
                                                  ),),

                                                Card(
                                                  semanticContainer: true,
                                                  child: Stack(
                                                      children: <Widget>[
                                                        Image.asset('image/ChanPark.jpg'),
                                                        Padding(padding: EdgeInsets.only(left:20),
                                                            child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom:300),
                                                                  ),

                                                                  Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Text('Chan Park', style: TextStyle(fontSize: 30, fontFamily:'MontserratExtraBold', color: Colors.white,
                                                                      shadows: <Shadow>[

                                                                        Shadow(
                                                                          offset: Offset(0, 0),
                                                                          blurRadius: 15.0,
                                                                          color: Color.fromRGBO(0, 0, 70, 0.8),
                                                                        ),
                                                                      ],)),),


                                                                  Text('Video/Editing Leader', style: TextStyle(fontSize: 20, fontFamily:'MontserratExtraBold', color: Colors.white,
                                                                    shadows: <Shadow>[

                                                                      Shadow(
                                                                        offset: Offset(0, 0),
                                                                        blurRadius: 15.0,
                                                                        color: Color.fromRGBO(0, 0, 70, 0.8),
                                                                      ),
                                                                    ],)
                                                                  ),
                                                                ]
                                                            ))
                                                      ]
                                                  ),),

                                                Card(
                                                  semanticContainer: true,
                                                  child: Stack(
                                                      children: <Widget>[
                                                        Image.asset('image/David.jpg'),
                                                        Padding(padding: EdgeInsets.only(left:20),
                                                            child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom:300),
                                                                  ),

                                                                  Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Text('David Na', style: TextStyle(fontSize: 30, fontFamily:'MontserratExtraBold', color: Colors.white,
                                                                      shadows: <Shadow>[

                                                                        Shadow(
                                                                          offset: Offset(0, 0),
                                                                          blurRadius: 15.0,
                                                                          color: Color.fromRGBO(0, 0, 70, 0.8),
                                                                        ),
                                                                      ],)),),


                                                                  Text('Design Leader', style: TextStyle(fontSize: 20, fontFamily:'MontserratExtraBold', color: Colors.white,
                                                                    shadows: <Shadow>[

                                                                      Shadow(
                                                                        offset: Offset(0, 0),
                                                                        blurRadius: 15.0,
                                                                        color: Color.fromRGBO(0, 0, 70, 0.8),
                                                                      ),
                                                                    ],)
                                                                  ),
                                                                ]
                                                            ))
                                                      ]
                                                  ),),

                                                Card(
                                                  semanticContainer: true,
                                                  child: Stack(
                                                      children: <Widget>[
                                                        Image.asset('image/Andrew.jpg'),
                                                        Padding(padding: EdgeInsets.only(left:20),
                                                            child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.only(bottom:300),
                                                                  ),

                                                                  Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Text('Andrew Sim', style: TextStyle(fontSize: 30, fontFamily:'MontserratExtraBold', color: Colors.white,
                                                                      shadows: <Shadow>[

                                                                        Shadow(
                                                                          offset: Offset(0, 0),
                                                                          blurRadius: 15.0,
                                                                          color: Color.fromRGBO(0, 0, 70, 0.8),
                                                                        ),
                                                                      ],)),),


                                                                  Text('History Research Leader', style: TextStyle(fontSize: 20, fontFamily:'MontserratExtraBold', color: Colors.white,
                                                                    shadows: <Shadow>[

                                                                      Shadow(
                                                                        offset: Offset(0, 0),
                                                                        blurRadius: 15.0,
                                                                        color: Color.fromRGBO(0, 0, 70, 0.8),
                                                                      ),
                                                                    ],)
                                                                  ),
                                                                ]
                                                            ))
                                                      ]
                                                  ),),
                                              ]
                                          ),
                                        ),
                                      ]
                                  ),),)
                          ),
                        );
                      },
                    ));
                  },
                    child: Stack(
                      children: <Widget> [
                        ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset('image/groupA.jpg', fit: BoxFit.cover,)
                ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(padding:EdgeInsets.only(bottom: 200)),
                            Padding(
                              padding: EdgeInsets.only(left:10),
                              child:Text('We are 22VZ', style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'MontserratExtraBold',
                                color: Colors.white,
                                  shadows: <Shadow>[

                              Shadow(
                              offset: Offset(0, 0),
                                blurRadius: 15.0,
                                color: Color.fromRGBO(0, 0, 70, 0.8),
                              ),],
                            )),),
                            Padding(
                              padding: EdgeInsets.only(left:10),
                              child:Text('Click and Learn More About Us', style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'MontserratRegular',
                                color: Colors.white,
                                shadows: <Shadow>[

                                  Shadow(
                                    offset: Offset(0, 0),
                                    blurRadius: 15.0,
                                    color: Color.fromRGBO(0, 0, 70, 1),
                                  ),],
                              )),),



                          ]
                        )

                      ],),),),

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
                                                          .docs[index]['image']}', fit: BoxFit.cover),),
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
              )]
        ));
  }
}
