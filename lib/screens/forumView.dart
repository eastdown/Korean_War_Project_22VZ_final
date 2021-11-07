import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/screens/post.dart';
import 'package:untitled/tools/appManual.dart';
import 'package:untitled/tools/drawer.dart';
import 'package:untitled/tools/drawerLogOut.dart';
import 'package:untitled/tools/forumWriting.dart';

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
      drawer: (FirebaseAuth.instance.currentUser != null)?
      DrawerForAll() : DrawerLogOut(),

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
                        return Padding(
                          padding: EdgeInsets.only(left: 10.sp, top: 20.sp, right: 10.sp),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Post()));
                              postIndex = index;
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(20.sp),

                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      StreamBuilder<DocumentSnapshot>(
                                          stream: FirebaseFirestore.instance.collection('UserImage').doc('${snapshot.data!.docs[index]['email']}').snapshots(),
                                          builder: (context, Imagesnapshot){
                                            if (snapshot.connectionState == ConnectionState.waiting){
                                              return CircularProgressIndicator();
                                            }
                                            else if (!Imagesnapshot.data!.exists){ //유저 이미지가 없으면
                                              return Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width * 0.1,
                                                  height: MediaQuery.of(context).size.width * 0.1,
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
                                                ),
                                              );
                                            }
                                            else{
                                              return Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width * 0.1,
                                                  height: MediaQuery.of(context).size.width * 0.1,
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
                                                ),
                                              );
                                            }
                                          }),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 10.sp),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                width: 270.sp,
                                                child: Flexible(
                                                  child: Text('${snapshot.data!.docs[index]['title']}',
                                                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,),
                                                ),
                                              ),
                                            ),
                                          ),

                                          (snapshot.data!.docs[index]['login'] == false) ?  Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(left: 10.sp, right: 5),
                                                child: Container(
                                                    constraints: BoxConstraints( maxWidth: 150),
                                                    child: Flexible(child: Text('${snapshot.data!.docs[index]['logoutName']}' , style: TextStyle(fontSize: 15.sp,overflow: TextOverflow.ellipsis))))
                                              ),
                                              Align(
                                                alignment: Alignment.center,
                                                  child: Icon(Icons.circle, color: Colors.blue,size: 8.sp)),
                                              Padding(
                                                  padding: EdgeInsets.only(left: 5.sp, right: 10),
                                                  child: Text('${snapshot.data!.docs[index]['displayDate']}' , style: TextStyle(fontSize: 15.sp, color: Colors.grey))
                                              ),
                                            ],
                                          )
                                            :
                                            StreamBuilder<DocumentSnapshot>(
                                              stream: FirebaseFirestore.instance.collection('UserName').doc('${snapshot.data!.docs[index]['email']}').snapshots(),
                                              builder: (context, DocumentSnapshot){
                                                if (!DocumentSnapshot.data!.exists){
                                                  return Row(
                                                    children: [
                                                      Padding(
                                                          padding: EdgeInsets.only(left: 10.sp, right: 5),
                                                          child: Container(
                                                              constraints: BoxConstraints( maxWidth: 150),
                                                              child: Flexible(child: Text('Anonymous User' , style: TextStyle(fontSize: 15.sp,overflow: TextOverflow.ellipsis))))
                                                      ),
                                                      Align(
                                                          alignment: Alignment.center,
                                                          child: Icon(Icons.circle, color: Colors.blue,size: 8.sp)),
                                                      Padding(
                                                          padding: EdgeInsets.only(left: 5.sp, right: 10),
                                                          child: Text('${snapshot.data!.docs[index]['displayDate']}' , style: TextStyle(fontSize: 15.sp, color: Colors.grey))
                                                      ),
                                                    ],
                                                  );
                                                }
                                                else {
                                                  return Row(
                                                    children: [
                                                      Padding(
                                                          padding: EdgeInsets.only(left: 10.sp, right: 5),
                                                          child: Container(
                                                              constraints: BoxConstraints( maxWidth: 150),
                                                              child: Flexible(child: Text('${DocumentSnapshot.data!['name']}' , style: TextStyle(fontSize: 15.sp,overflow: TextOverflow.ellipsis))))
                                                      ),
                                                      Align(
                                                          alignment: Alignment.center,
                                                          child: Icon(Icons.circle, color: Colors.blue,size: 8.sp)),
                                                      Padding(
                                                          padding: EdgeInsets.only(left: 5.sp, right: 10),
                                                          child: Text('${snapshot.data!.docs[index]['displayDate']}' , style: TextStyle(fontSize: 15.sp, color: Colors.grey))
                                                      ),
                                                    ],
                                                  );
                                                }
                                              })
                                        ],
                                      ),

                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15.sp, bottom: 10.sp),
                                    child: Text(
                                      '${snapshot.data!.docs[index]['content']}',
                                    style: TextStyle(fontSize: 18.sp, color: Colors.black54),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ),

                                  (snapshot.data!.docs[index]['imageUrl'] == null)? Padding(padding: EdgeInsets.zero,)
                                  : SizedBox(
                                    height: 150.sp,
                                    width: 350.sp,
                                    child: Image.network('${snapshot.data!.docs[index]['imageUrl']}',
                                      fit: BoxFit.cover
                                    )
                                  ),

                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('Forum').doc('${snapshot.data!.docs[index].id}').collection('comment').orderBy("date", descending: false).snapshots(),
                                  builder: (context, snapshot){
                                    return Row(
                                      children: [
                                        Icon(Icons.mode_comment, size: 18.sp, color: Colors.blue),
                                        Padding(
                                          padding: EdgeInsets.only (left: 5),
                                          child: Text('${snapshot.data?.docs.length}', style: TextStyle(fontSize: 18.sp, color: Colors.black54))
                                        )
                                      ],
                                    );
                                  })

                                  ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              )

                            ),
                          ),
                        );
                      }
                      );
                }),


          ],
        )
      ),
        floatingActionButton: FloatingActionButton.extended(onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ForumWriting()));
        },
          icon: Icon(Icons.post_add_outlined, size: 20.sp,),
          backgroundColor: Color.fromRGBO(
            144, 210, 140, 1.0),
          label: Text('Post', style: TextStyle(fontSize: 20.sp),),
        ))
    );
  }
}
