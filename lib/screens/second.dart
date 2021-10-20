import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);

static const String _title = 'Flutter Code Sample';

@override
Widget build(BuildContext context) {
  return const MaterialApp(
    title: _title,
    home: First(),
  );
}
}

/// This is the stateless widget that the main application instantiates.
class First extends StatelessWidget {
  const First({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TabBar(
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
            Center(
              child:Text("adfadfad")
            ),
            Center(
              child: Text("It's cloudy here"),
            ),
            Center(
              child: Text("It's rainy here"),
            ),
            Center(
              child: Text("It's sunny here"),
            ),
          ],
        ),
      ),
    );
  }
}
