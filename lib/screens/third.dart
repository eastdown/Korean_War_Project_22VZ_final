import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/tools/appManual.dart';
import 'package:untitled/tools/drawer.dart';
import 'package:untitled/tools/drawerLogOut.dart';

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
    return ScreenUtilInit(
        designSize: Size(390, 763),

    builder: () => Scaffold(
        appBar: AppBar(
          toolbarHeight: 69.sp,
          iconTheme: const IconThemeData(color:Colors.grey),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset('image/logo.jpg', fit: BoxFit.fitHeight, height: 55.h),
          actions: [
            GestureDetector(
              onTap:() {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AppManual()));
              },
              child: Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015)),
                    Icon(Icons.book_outlined, size: 26.sp),
                    Text('   App\nManual',style: TextStyle(color: Colors.black54, fontSize: 10.sp),)]),),
            Padding(padding:EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.055))],

        ),
        drawer: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot){
              if (!snapshot.hasData){
                return DrawerLogOut();
              }
              return DrawerForAll();
            }

        ),
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
                        padding: EdgeInsets.only( bottom:20.sp, top: 20.sp),
                        child: SizedBox(
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AnvPage()));
                                currentIndex = index;
                                },
                              child: Column(
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only(right:10.sp, left: 10.sp, bottom:10.sp),
                                        child: Image.network('${snapshot.data!.docs[index]['image']}', fit: BoxFit.fitWidth,)),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 15.sp, right: 15.sp),
                                      child: Align(
                                        alignment: Alignment
                                            .centerLeft,
                                        child: Text(snapshot.data!
                                            .docs[index]['title'],
                                          style: TextStyle(
                                              fontSize: 30.sp, fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 15.sp, right: 15.sp),
                                      child: Align(
                                        alignment: Alignment
                                            .centerLeft,
                                        child: Text(snapshot.data!
                                            .docs[index]['subexplanation'],
                                          style: TextStyle(
                                              fontSize: 20.sp, color: Color.fromRGBO(
                                              120, 120, 120, 1.0)),
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
));
}}
