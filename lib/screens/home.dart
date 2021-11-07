import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/screens/forumView.dart';
import 'package:untitled/screens/post.dart';
import 'package:untitled/tools/appManual.dart';
import 'package:untitled/tools/drawer.dart';
import 'package:untitled/tools/drawerLogOut.dart';

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
    return ScreenUtilInit(
        designSize: Size(390, 763),

      builder: () => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
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
          drawer: (FirebaseAuth.instance.currentUser != null)?
              DrawerForAll() : DrawerLogOut(),


          body: ListView(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.sp, left: 20.sp),
                      child: Text('Home', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp),),)),

                Padding(padding:EdgeInsets.only(bottom:20.sp)),

                StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance.collection('UserName').doc('${FirebaseAuth.instance.currentUser?.email}').snapshots(),
                    builder: (context, snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting){
                        return Divider();
                      }
                      else if (!snapshot.data!.exists){
                        return Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: Text('Welcome, Anonymous User', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black54)));
                      }
                      else{
                        return Padding(
                            padding: EdgeInsets.only(left: 20.sp),
                            child: Text('Welcome, ' + '${snapshot.data!['name']}', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black54))
                        );}
                    }),

                Padding(padding:EdgeInsets.only(bottom:40.sp)),



                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Announcement').snapshots(),
                    builder: (context, snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting){
                        return Align(alignment: Alignment.center,child:CircularProgressIndicator() );
                      }
                      else if (!snapshot.hasData){
                        return Padding(padding: EdgeInsets.zero
                        );
                      }
                      return Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06, bottom: 50.sp),

                          child: Container(
                              height:  280.sp,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 0.4,
                                  color: Colors.grey,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ConstrainedBox(
                                  constraints: BoxConstraints(),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05, top: 10.sp, bottom: 10.sp),
                                              child: Icon(Icons.volume_up_outlined, color: Colors.greenAccent, size: 25.sp)
                                          ),
                                          Padding(
                                              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05, top: 10.sp, bottom: 10.sp),
                                              child:Text(snapshot.data!.docs[0]['title'], style: TextStyle(height: 1.6, fontSize:25.sp,fontWeight: FontWeight.bold))
                                          )],
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                      ),

                                      Padding(
                                          padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05, bottom: 10),
                                          child:Text(snapshot.data!.docs[0]['content'].replaceAll("\\n", "\n"), style: TextStyle(height: 1.6, fontSize:15.w))
                                      ),


                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  )
                              )
                          ));

                    }

                ),


                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Forum').snapshots(),
                    builder: (context, snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting){
                        return Align(alignment: Alignment.center,child:CircularProgressIndicator() );
                      }
                      else if (!snapshot.hasData){
                        return Text('Error Occured while getting data from the database');
                      }
                      return Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06, right: MediaQuery.of(context).size.width * 0.06),

                          child: Container(
                              height:  275.sp,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: 0.4,
                                  color: Colors.grey,
                                ),
                              ),
                              child: ConstrainedBox(
                                  constraints: BoxConstraints(),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                          children: <Widget>[
                                            Padding(
                                                padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05, top: 10.sp, bottom: 10.sp),
                                                child: Icon(Icons.forum_outlined, color: Colors.lightBlueAccent, size: 25.sp)
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05, top: 10.sp, bottom: 10.sp),
                                                child:Text('General Forum', style: TextStyle(height: 1.6, fontSize:25.w,fontWeight: FontWeight.bold))
                                            )]),

                                      StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance.collection('Forum').orderBy("date", descending: true).snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Divider(height: 1, thickness: 1);
                                            }
                                            return SingleChildScrollView(
                                                scrollDirection: Axis.vertical,
                                                child: ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: snapshot.data!.docs.length < 4 ?  snapshot.data!.docs.length: 4,
                                                    itemExtent: 35.sp,
                                                    itemBuilder: (context, index) {
                                                      return ListTile(
                                                        title: Row(
                                                          children: <Widget>[
                                                            Flexible(
                                                                child: Text('${snapshot.data!.docs[index]['title']}',
                                                                  style: TextStyle(fontWeight: FontWeight.bold,
                                                                  fontSize: 17.sp),
                                                                  overflow: TextOverflow.ellipsis,)),
                                                            Padding(child:Text('${snapshot.data!.docs[index]['displayDate']}',
                                                            style: TextStyle(fontSize: 17.sp),
                                                            ), padding:EdgeInsets.only(left: 10.sp) ),
                                                          ],
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        ),
                                                        onTap: (){
                                                          postIndex = index;
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      Post()));
                                                        },
                                                      );}));}),
                                      Padding(padding: EdgeInsets.only( bottom: 10.sp, top: 15.sp, right: 10.sp),
                                          child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: TextButton(
                                                  onPressed: (){
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ForumView()));
                                                  },
                                                  child: Text('Read More')
                                              )
                                          )
                                      )


                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  )
                              ))
                      );

                    }

                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 50.sp),
                ),


                Divider(color: Colors.black, thickness: 2, ),

                Padding(
                  padding: EdgeInsets.only(left:15.sp),
                  child: Text('Latest News', style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold)),
                ),

                Padding(
                    padding:EdgeInsets.only(bottom: 30.sp)
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
                                    bottom: 20.sp),
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
                                                  right: 10.sp,
                                                  left: 10.sp,
                                                  bottom: 10.sp),
                                              child: Image.network(
                                                  '${snapshot.data!
                                                      .docs[index]['image']}'),),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 15.sp, right: 15.sp),
                                              child: Align(
                                                alignment: Alignment
                                                    .centerLeft,
                                                child: Text(snapshot.data!
                                                    .docs[index]['title'],
                                                  style: TextStyle(
                                                      fontSize: 30.sp, fontWeight: FontWeight.bold ),
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
                          });
                    })
              ]
          ))
    );
  }
}
