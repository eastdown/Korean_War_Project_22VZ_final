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
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TabBar(
            isScrollable: true,
            labelStyle: TextStyle(fontSize:12.5, fontWeight: FontWeight.bold),
            labelColor: Colors.black,
            tabs: [
              Tab(text: "What we do"),
              Tab(text: "Why we do" ),
              Tab(text: "Leadership"),
              Tab(text: "Contact"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Scaffold(
              body: Column(
                children: <Widget> [
                  Center(),

                ]
              ),
            ),
            Center(
              child: Text("It's cloudy here"),
            ),


            Scaffold(
    body:  SingleChildScrollView(
    child: Column(

    mainAxisSize: MainAxisSize.min,
    children: <Widget>[

      Image.asset('image/groupphoto.jpg'),

    Text(
    'Headline',
    style: TextStyle(fontSize: 18),
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
          Image.asset('image/ChanPark.jpg'),
        Center(child: Text("someText")),
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
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}
