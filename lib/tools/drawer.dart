import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/screens/aboutUS.dart';
import 'package:untitled/screens/forumView.dart';
import 'package:untitled/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/screens/profile.dart';
import 'package:untitled/screens/third.dart';

import '../main.dart';


class DrawerForAll extends StatefulWidget {
  const DrawerForAll({Key? key}) : super(key: key);

  @override
  _DrawerForAllState createState() => _DrawerForAllState();
}

class _DrawerForAllState extends State<DrawerForAll> {
  signOut (){
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  Widget getDrawer (BuildContext context){
    var drawer = Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          UserAccountsDrawerHeader(
            currentAccountPicture: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('UserImage').doc('${FirebaseAuth.instance.currentUser?.email}').snapshots(),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return CircularProgressIndicator();
                  }
                  else if(snapshot.data!.exists){
                    return CircleAvatar(
                      backgroundImage: NetworkImage('${snapshot.data!['image']}'),
                    );
                  } else{
                    return CircleAvatar(
                      backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/vz--korean-war-project.appspot.com/o/profilePhoto%2FSampleProfile.jpeg?alt=media&token=b19d872b-b906-4fe9-bc69-1e779ee6aa79'),
                    );
                  }
                }),

            accountEmail: Text("${FirebaseAuth.instance.currentUser?.email}"),
            accountName: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('UserName').doc('${FirebaseAuth.instance.currentUser?.email}').snapshots(),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return Divider();
                  }
                  else if(snapshot.data!.exists){
                    return Text('${snapshot.data!['name']}');
                    }
                    return Text('UserName');
                }),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(112, 236, 117, 1.0),
                    Color.fromRGBO(38, 151, 136, 1.0),
                  ],),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                )),
          ),
          ListTile(
              leading: Icon(Icons.home_outlined, color: Colors.black54),
              title: Text('Home', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()));
              }
          ),
          ListTile(
              leading: SizedBox(child: Image.asset('image/logoP.jpg'), height: 30.sp),
              title: Text('Korea Today', style: TextStyle(color: Colors.black87)),
              onTap: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Second()));
              }
          ),
          ListTile(
              leading: Icon(Icons.forum_outlined, color: Colors.black54),
              title: Text('General Forum', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ForumView()));
              }
          ),

          ListTile(
              leading: Icon(Icons.settings, color: Colors.black54),
              title: Text('Profile', style: TextStyle(color: Colors.black87)),
              onTap: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()));
              }
          ),
          ListTile(
              leading: Icon(Icons.people_outline, color: Colors.black54),
              title: Text('About Us', style: TextStyle(color: Colors.black87)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              }
          ),

          Divider(
              color: Colors.black54
          ),
          ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.black54),
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Sign Out?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {signOut();},
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
              title: Text('Sign Out')
          ),
        ],
      ),
    );
    return drawer;
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(390, 763),

    builder: () =>getDrawer(context));
  }
}
