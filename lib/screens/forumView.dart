import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/screens/post.dart';
import 'package:untitled/tools/appManual.dart';
import 'package:untitled/tools/drawer.dart';
import 'package:untitled/tools/forumWriting.dart';

import 'home.dart';


int postIndex = 0;

class ForumView extends StatefulWidget {
  const ForumView({Key? key}) : super(key: key);

  @override
  _ForumViewState createState() => _ForumViewState();
}

class _ForumViewState extends State<ForumView> {

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
      drawer: DrawerForAll(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 20.sp, left: 20.sp),
                child: Text('General Forum', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.sp),),)),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Forum').orderBy("date", descending: true).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Divider(height: 1, thickness: 1);
                  }
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            child: GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Post()));
                                postIndex = index;
                              },
                        child: Card(
                              child: Row(
                                children: <Widget> [
                                  Padding(
                                    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03, top: MediaQuery.of(context).size.width *0.02,bottom: MediaQuery.of(context).size.width *0.02,),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.height *0.15,
                                      height: MediaQuery.of(context).size.height * 0.15,
                                      child: Image.network('${snapshot.data!.docs[index]['imageUrl']}', fit: BoxFit.cover),),),

                                  Flexible(
                                      child: Column(children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, top: MediaQuery.of(context).size.height * 0.02, bottom: MediaQuery.of(context).size.height * 0.01),
                                        child: Text('${snapshot.data!.docs[index]['title']}',
                                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,)
                                    ),
                                        Row(
                                          children: <Widget>[
                                            StreamBuilder<DocumentSnapshot>(
                                                stream: FirebaseFirestore.instance.collection('UserImage').doc('${snapshot.data!.docs[index]['email']}').snapshots(),
                                                builder: (context, Imagesnapshot){
                                                  if (snapshot.connectionState == ConnectionState.waiting){
                                                    return CircularProgressIndicator();
                                                  }
                                                  else if (!Imagesnapshot.data!.exists){ //유저 이미지가 없으면
                                                    return Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width * 0.07,
                                                          height: MediaQuery.of(context).size.width * 0.07,
                                                          decoration: BoxDecoration(
                                                            color: const Color(0xff7c94b6),
                                                            image: DecorationImage(
                                                              image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/vz--korean-war-project.appspot.com/o/profilePhoto%2FSampleProfile.jpeg?alt=media&token=b19d872b-b906-4fe9-bc69-1e779ee6aa79'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            borderRadius: BorderRadius.circular(50.sp),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.5),
                                                                spreadRadius: 1,
                                                                blurRadius: 1,
                                                                // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                                  }
                                                  else{
                                                    return Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width * 0.07,
                                                          height: MediaQuery.of(context).size.width * 0.07,
                                                          decoration: BoxDecoration(
                                                            color: const Color(0xff7c94b6),
                                                            image: DecorationImage(
                                                              image: NetworkImage('${Imagesnapshot.data!['image']}'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            borderRadius: BorderRadius.circular(50.sp),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey.withOpacity(0.5),
                                                                spreadRadius: 1,
                                                                blurRadius: 1,
                                                                // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                        ));
                                                  }
                                                }),
                                            StreamBuilder<DocumentSnapshot>(
                                                stream: FirebaseFirestore.instance.collection('UserName').doc('${snapshot.data!.docs[index]['email']}').snapshots(),
                                                builder: (context, DocumentSnapshot){
                                                  if (DocumentSnapshot.connectionState == ConnectionState.waiting){
                                                    return Divider();
                                                  }
                                                  else if (!DocumentSnapshot.data!.exists){ //이름이 없으면
                                                    return Padding(
                                                        padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.01),
                                                        child: Text('Anonymous User', style: TextStyle(fontSize: 15.sp))
                                                    );
                                                  }
                                                  else{
                                                    return Padding( //이름이 있으면
                                                        padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.01),
                                                        child: Text('${DocumentSnapshot.data!['name']}', style: TextStyle(fontSize: 15.sp))
                                                    );
                                                  }
                                                }),
                                          ],
                                        ),


                                    Padding(
                                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01, left: MediaQuery.of(context).size.width * 0.03),
                                        child:  Text('${snapshot.data!.docs[index]['displayDate']}', style: TextStyle(fontSize: 13.sp),)
                                    )
                                  ],
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  ))

                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            )
                        ),
                          height: MediaQuery.of(context).size.height * 0.18,
                          width: MediaQuery.of(context).size.width * 0.9
                        );
                      }
                      );
                }),


          ],
        )
      ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ForumWriting()));
        },
          child: Icon(Icons.post_add_outlined),
          backgroundColor: Color.fromRGBO(
            144, 210, 140, 1.0),
        ))
    );
  }
}
