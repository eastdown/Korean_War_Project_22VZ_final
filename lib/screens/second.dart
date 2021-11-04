import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: First(),
  );
}
}

/// This is the stateless widget that the main application instantiates.
class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

@override
_firstState createState() => _firstState();
}

class _firstState extends State<First>{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TabBar(
            labelStyle: TextStyle(fontSize:15, fontWeight: FontWeight.bold),
            labelColor: Colors.black,
            tabs: [
              Tab(text: "About us"),
              Tab(text: "Leadership"),
              Tab(text: "Contact"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Scaffold(
              body: SingleChildScrollView(
            child: ConstrainedBox(
            constraints: BoxConstraints(),
        child: Column(
                children: <Widget> [

                  Padding(
                      padding: EdgeInsets.only(left:10, right:10, top:20),
                      child: Text('Who We Are', style: TextStyle(fontSize: 50, fontFamily: 'MontserratExtraBold', ))
                  ),
                  Padding(
                      padding: EdgeInsets.only(left:20, right: 40, top:20),
                      child: Text('We are a youth organization that strives to connect, communicate, and show gratitude to the Korean War Veterans.',
                          style: TextStyle(fontSize: 20, fontFamily: 'NotoSerif'))
                  ),

                  Padding(
                      padding: EdgeInsets.only(left:10, top: 30, right:10),
                      child: Text('What We Do', style: TextStyle(fontSize: 50, fontFamily: 'MontserratExtraBold',))
                  ),
                  Padding(
                      padding: EdgeInsets.only(left:20, right: 40, top:20),
                      child: Text('Our goal is to show how current-day Korea has changed since the Korean War. We post videos, write articles, and conduct research on the history of the war to connect with the youth, who do not know much, and to remember the services of the veterans. \n \n But that is not what we only do. Another goal of ours is to give back to the veterans who have served in the war. There are many of them who are poor and in need of aid. We hope to raise a charity for them to meet their needs and show appreciation for their service.',
                          style: TextStyle(fontSize: 20, fontFamily: 'NotoSerif'))
                  ),
                  /*Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left:10, top: 30),
                      child: Text('Purpose', style: TextStyle(fontSize: 50, fontFamily: 'MontserratExtraBold'))
                  ),),

                  Padding(
                      padding: EdgeInsets.only(left:20, right: 40),
                      child: Text('',
                          style: TextStyle(fontSize: 25, fontFamily: 'NotoSerif'))
                  ),*/
                ]
              ),),)
            ),


            Scaffold(
    body:  SingleChildScrollView(
    child: Column(

    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child:Padding(
        padding: EdgeInsets.only(bottom: 20, top:10, left: 10),
        child: Text(
        'Leadership',
        style: TextStyle(fontSize: 50, fontFamily:'MontserratExtraBold'),
      ),),),
    Align(
      alignment: Alignment.centerLeft,
      child:Text('  Our team has 5 lea\nders, each' ),
    ),
    Text(
    'Leaders',
    style: TextStyle(fontSize: 18, fontFamily: 'MontserratExtraBold'),
      textAlign: TextAlign.left,
    ),

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
          Image.asset('image/Amber.jpg'),
        Center(child: Text("someText")),
        ]
        ),),
      Card(
          semanticContainer: true,
          child: Stack(
              children: <Widget>[
                Image.asset('image/ChanPark.jpg'),
                Text("Chan Park", style: TextStyle(fontSize: 30, color: Colors.white)),

              ]
          )
      ),
      Card(
          semanticContainer: true,
          child: Stack(
              children: <Widget>[
                Image.asset('image/ChanPark.jpg'),
                Center(child: Text("someText")),
              ]
          )
      ),
    ]
    ),
    ),

    Text(
    'Demo Headline 2',
    style: TextStyle(fontSize: 18),
    ),
    Card(
    child: ListTile(title: Text('Motivation $int'), subtitle: Text('this is a description of the motivation')),
    ),
    Card(
    child: ListTile(title: Text('Motivation $int'), subtitle: Text('this is a description of the motivation')),
    ),
    Card(
    child: ListTile(title: Text('Motivation $int'), subtitle: Text('this is a description of the motivation')),
    ),
    Card(
    child: ListTile(title: Text('Motivation $int'), subtitle: Text('this is a description of the motivation')),
    ),
    Card(
    child: ListTile(title: Text('Motivation $int'), subtitle: Text('this is a description of the motivation')),
    ),

    ])
    ),),


            Scaffold(
              body: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left:10, top: 10),
                    child: Text('Contact', style: TextStyle(fontSize: 50, fontFamily: 'MontserratExtraBold')),
                  )
                ]
              )
            )


          ],
        ),
      ),
    );
  }
}
