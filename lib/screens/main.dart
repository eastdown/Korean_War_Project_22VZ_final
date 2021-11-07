import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/second.dart';
import 'package:untitled/screens/third.dart';
import 'package:untitled/screens/fourth.dart';
import 'package:untitled/screens/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '22VZ';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _currentIndex = 0;

  final List<Widget> _children = [Home(), Second(), First(),];
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        iconTheme: const IconThemeData(color:Colors.grey),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('image/logo.jpg', fit: BoxFit.fitHeight, height: 55),
        
        actions: <Widget>[
          /*IconButton(
            icon: const Icon(Icons.alarm_on),
            color: Colors.grey,
            tooltip: 'Show Snackbar',
            onPressed: () {
              //알람설정 오케이로 해두면 알람이 감, 아니면 안감
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),*/
          /*IconButton(
            icon: const Icon(Icons.bookmark),
            color: Colors.grey,
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: const Center(
                      child: Text(
                        'This is the next page',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),*/
        ],
      ),
      /*drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                setState(() {
                });
              }
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              //onTap
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              //onTap
            ),
          ],
        ),
      ),*/ //drawer
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onTap,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label:'Home',
            icon: SizedBox(
              height: 30,
                width: 50,
                child:Image.asset('image/home.png')),
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 30,
                child: Image.asset('image/logoP.jpg'),),

            label: 'Korea Today',
          ),
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 30,
              width: 50,
              child:Image.asset('image/logoL.jpg'),),
            label: 'Our Team',
          ),
        ],
        //currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        //onTap: _onItemTapped,
      ),
    );
  }
}


