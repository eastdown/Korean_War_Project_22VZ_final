import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'forumView.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  void deleteDoc(String docID) {
    FirebaseFirestore.instance.collection('Forum').doc(docID).delete();
  }

  @override
  Widget build(BuildContext context) {





    return ScreenUtilInit(
        designSize: Size(390, 763),

        builder: () => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Forum').orderBy("date", descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            backgroundColor: Colors.white,
              appBar: AppBar(
                  elevation: 0,
                  iconTheme: const IconThemeData(color: Colors.grey),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                title: Text('Post', style: TextStyle(color: Colors.black)),
                actions: [
                  ('${FirebaseAuth.instance.currentUser?.email}' == snapshot.data!.docs[postIndex]['email']) ? TextButton(child: Icon(Icons.delete, color: Colors.black54,),
                  onPressed: (){

                    Future<void> _DeleteWarning() async {
                      return showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Do you want to delete this post?'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Yes'),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection("Forum")
                                      .doc('${snapshot.data!.docs[postIndex].id}')
                                      .delete();
                                  int count = 0;
                                  Navigator.popUntil(context, (route) {
                                    return count++ == 2;
                                  });
                                }
                              ),
                              TextButton(
                                child: Text('No'),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        },
                      );
                    }
                    _DeleteWarning();
                  },
                  ) : Padding(padding: EdgeInsets.all(0))
                ],
              ),
              body: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(),
                      child: Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.08, right: MediaQuery.of(context).size.width * 0.08, top: 10.sp, bottom: 10.sp),
                                child:Text(snapshot.data!.docs[postIndex]['title'], style: TextStyle(height: 1.6.h, fontSize:30.sp,fontWeight: FontWeight.bold))
                            ),
                            Row(
                              children: <Widget>[
                                StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance.collection('UserImage').doc('${snapshot.data!.docs[postIndex]['email']}').snapshots(),
                                    builder: (context, snapshot){
                                      if (snapshot.connectionState == ConnectionState.waiting){
                                        return CircularProgressIndicator();
                                      }
                                      else if (!snapshot.data!.exists){ //profile 이미지가 없으면 샘플 이미지를 업로드
                                        return Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.07,
                                              height: MediaQuery.of(context).size.width * 0.07,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50.sp),
                                                color: const Color(0xff7c94b6),
                                                image: DecorationImage(
                                                  image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/vz--korean-war-project.appspot.com/o/profilePhoto%2FSampleProfile.jpeg?alt=media&token=b19d872b-b906-4fe9-bc69-1e779ee6aa79'),
                                                  fit: BoxFit.cover,
                                                ),
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
                                        return Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.07,
                                          height: MediaQuery.of(context).size.width * 0.07,
                                          decoration: BoxDecoration(
                                            color: const Color(0xff7c94b6),
                                            image: DecorationImage(
                                              image: NetworkImage('${snapshot.data!['image']}'),
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
                                    stream: FirebaseFirestore.instance.collection('UserName').doc('${snapshot.data!.docs[postIndex]['email']}').snapshots(),
                                    builder: (context, snapshot){
                                      if (snapshot.connectionState == ConnectionState.waiting){
                                        return Divider();
                                      }
                                      else if (!snapshot.data!.exists){ //유저가 지정한 이름이 없으면
                                        return Padding(
                                            padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.02),
                                            child: Text('Anonymous User', style: TextStyle(fontSize: 15.sp)));
                                      }
                                      else{ //이름이 있으면
                                        return Padding(
                                            padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.02),
                                            child: Text('${snapshot.data!['name']}', style: TextStyle(fontSize: 15.sp))
                                        );
                                      }
                                    }),
                              ],
                            ),

                            Padding(
                                padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.08, right: 15.sp, top: 5.sp),
                                child:Text(snapshot.data!.docs[postIndex]['displayDate'], style: TextStyle(height: 1.6.h, fontSize:15.sp))
                            ),


                            Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08, right: MediaQuery.of(context).size.width * 0.08, top: MediaQuery.of(context).size.height * 0.04),
                                child:Text(snapshot.data!.docs[postIndex]['content'].replaceAll("\\n", "\n"), style: TextStyle(height: 1.6.h, fontSize:20.sp,))
                            ),

                            Padding(
                                padding: EdgeInsets.only(bottom: 50.sp)
                            ),

                            '${snapshot.data!.docs[postIndex]['imageUrl']}' == 'https://firebasestorage.googleapis.com/v0/b/vz--korean-war-project.appspot.com/o/forumSample.PNG?alt=media&token=c0c6b228-465c-4b9e-8f5b-ce5424602fe5' ? Padding(padding: EdgeInsets.only(top: 20)) :
                            Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08, right: MediaQuery.of(context).size.width * 0.08, top: MediaQuery.of(context).size.height * 0.04, bottom: 50.sp),
                                child: Image.network('${snapshot.data!.docs[postIndex]['imageUrl']}', fit: BoxFit.cover)
                            ),

                          ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      )))
          );
        }
    ));
  }
}
