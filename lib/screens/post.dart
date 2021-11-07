import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'forumView.dart';
import 'package:intl/intl.dart';


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
    String? comment;
    TextEditingController commentController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    String? postID;

    Future<void> _commentFillOut() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cannot Post Your Comment'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Please fill out the comment'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    Future<void> _nameFillOut() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cannot Post Your Comment'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('Please fill out your name'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    String name = '';
    String? userImage;
    String? userName;

    return ScreenUtilInit(
        designSize: Size(390, 763),

        builder: () => FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('Forum').orderBy('date', descending: true).get(),
        builder: (context, snapshot) {

          return Scaffold(
            backgroundColor: Colors.white,
              appBar: AppBar(
                  elevation: 0,
                  iconTheme: const IconThemeData(color: Colors.grey),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                title: Text('Post', style: TextStyle(color: Colors.black)),
                actions: [
                  ('${FirebaseAuth.instance.currentUser?.email}' == snapshot.data!.docs[postIndex]['email'] && '${FirebaseAuth.instance.currentUser?.email}' != 'null')
                      ? TextButton(child: Icon(Icons.delete, color: Colors.black54,),
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
                                     if (!snapshot.data!.exists){ //profile 이미지가 없으면 샘플 이미지를 업로드
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

                                (snapshot.data!.docs[postIndex]['login'] == false) ?  Padding(
                                    padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.02),
                                    child: Text('${snapshot.data!.docs[postIndex]['logoutName']}', style: TextStyle(fontSize: 15.sp))
                                ):
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

                            ('${snapshot.data!.docs[postIndex]['imageUrl']}' == 'null') ? Padding(padding: EdgeInsets.only(top: 20)) :
                            Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08, right: MediaQuery.of(context).size.width * 0.08, top: MediaQuery.of(context).size.height * 0.04, bottom: 50.sp),
                                child: Image.network('${snapshot.data!.docs[postIndex]['imageUrl']}', fit: BoxFit.cover)
                            ),




                            Divider(),
                            Padding(
                                padding: EdgeInsets.only(bottom: 10.sp, left: 15.sp, top: 10.sp),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text('Comment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),))

                            ),


                            Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        boxShadow: [

                                        ],
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[


                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            (FirebaseAuth.instance.currentUser != null) ?
                                            StreamBuilder<DocumentSnapshot>(
                                                stream: FirebaseFirestore.instance.collection('UserImage').doc('${FirebaseAuth.instance.currentUser?.email}').snapshots(),
                                                builder: (context, snapshot){
                                                  if (!snapshot.data!.exists){ //profile 이미지가 없으면 샘플 이미지를 업로드
                                                    return Padding(padding: EdgeInsets.only(left: 15.sp, right: 10.sp),
                                                        child: Container(
                                                          width: 50.sp,
                                                          height: 50.sp,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(15.sp),
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
                                                    return Padding(padding: EdgeInsets.only(left: 15.sp),
                                                        child: Container(
                                                          width: 50.sp,
                                                          height: 50.sp,
                                                          decoration: BoxDecoration(
                                                            color: const Color(0xff7c94b6),
                                                            image: DecorationImage(
                                                              image: NetworkImage('${snapshot.data?['image']}'),
                                                              fit: BoxFit.cover,
                                                            ),
                                                            borderRadius: BorderRadius.circular(15.sp),
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
                                                })
                                                :  Padding(padding: EdgeInsets.only(left: 15.sp, right: 10.sp),
                                                child: Container(
                                                  width: 50.sp,
                                                  height: 50.sp,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15.sp),
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
                                                )),


                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                (FirebaseAuth.instance.currentUser != null) ? Padding(padding: EdgeInsets.zero,) :
                                                Padding(
                                                  padding: EdgeInsets.only(right: 30.sp, bottom: 10.sp ),
                                                  child: Container(
                                                    height: 40.sp,
                                                    width: 150.sp,
                                                    child:
                                                    Align(
                                                      alignment: Alignment.center,
                                                      child: TextField(
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          contentPadding:
                                                          EdgeInsets.symmetric( horizontal: 20.sp),
                                                          hintText: 'Name',
                                                        ),
                                                        controller: nameController,

                                                      ),),),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    SizedBox(

                                                      width: 300.sp,
                                                      child:
                                                      Align(
                                                        alignment: Alignment.center,
                                                        child: TextField(
                                                          keyboardType: TextInputType.multiline,
                                                          maxLines: null,
                                                          decoration: InputDecoration(
                                                            border: OutlineInputBorder(),
                                                            contentPadding:
                                                            EdgeInsets.symmetric(vertical: 40.sp, horizontal: 20.sp),
                                                            hintText: 'Type a comment. . .',
                                                          ),
                                                          controller: commentController,
                                                        ),),),

                                                    Padding(
                                                          padding: EdgeInsets.only(top: 10.sp),
                                                          child: FloatingActionButton.extended(
                                                            onPressed: (){
                                                              if (comment == ''){
                                                                _commentFillOut();
                                                              } else if(FirebaseAuth.instance.currentUser == null && nameController.text == ''){
                                                                _nameFillOut();
                                                              }
                                                              else {

                                                                FirebaseFirestore.instance.collection('Forum').doc('${snapshot.data!.docs[postIndex].id}').collection('comment').doc().set({
                                                                  'comment' : commentController.text,
                                                                  'displayName': nameController.text,
                                                                  'email': "${FirebaseAuth.instance.currentUser?.email}",
                                                                  'userImage': 'https://firebasestorage.googleapis.com/v0/b/vz--korean-war-project.appspot.com/o/profilePhoto%2FSampleProfile.jpeg?alt=media&token=b19d872b-b906-4fe9-bc69-1e779ee6aa79',
                                                                  'date': DateTime.now().toUtc(),
                                                                  'displayDate' : DateFormat.yMMMd('en_US').format(DateTime.now()),
                                                                  'logOut': (FirebaseAuth.instance.currentUser != null) ? false: true
                                                                });
                                                                commentController.clear();
                                                                nameController.clear();
                                                              }

                                                            },
                                                            label: Text('Submit', style: TextStyle(fontSize: 15.sp),),
                                                            icon: Icon(Icons.arrow_forward, size: 15.sp),
                                                            backgroundColor: Color.fromRGBO(96, 170, 122, 1.0),
                                                          ),



                                                        ),
                                                      ],
                                                ),
                                              ],
                                            ),

                                            Padding(padding: EdgeInsets.only(left:15.sp))
                                          ],

                                        ),

                                        StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance.collection('Forum').doc('${snapshot.data!.docs[postIndex].id}').collection('comment').orderBy("date", descending: true).snapshots(),
                                            builder: (context, snapshot) {
                                              if (!snapshot.hasData){
                                                return Center(child: Text('No comment'));
                                              }

                                              return ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data?.docs.length,
                                                  itemBuilder: (context, index) {
                                                    return Container(
                                                        padding: const EdgeInsets.all(20.0),
                                                        constraints: BoxConstraints(
                                                          maxWidth: MediaQuery.of(context).size.width * 0.9,
                                                        ),

                                                        child: Row(
                                                          children: <Widget>[

                                                            //comment Profile image
                                                            (FirebaseAuth.instance.currentUser == null) ?
                                                            CircleAvatar(
                                                              backgroundImage: NetworkImage('${snapshot.data?.docs[index]['userImage']}'),
                                                              radius: 20,
                                                            ): StreamBuilder<DocumentSnapshot>(
                                                                stream: FirebaseFirestore.instance.collection('UserImage').doc('${snapshot.data!.docs[index]['email']}').snapshots(),
                                                                builder: (context, Imagesnapshot){
                                                                  if (!Imagesnapshot.data!.exists){ //유저 이미지가 없으면
                                                                    return CircleAvatar(
                                                                  backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/vz--korean-war-project.appspot.com/o/profilePhoto%2FSampleProfile.jpeg?alt=media&token=b19d872b-b906-4fe9-bc69-1e779ee6aa79'),
                                                                      radius: 20,
                                                                  );
                                                                  }
                                                                  else{
                                                                    return CircleAvatar(
                                                                      backgroundImage: NetworkImage('${Imagesnapshot.data!['image']}'),
                                                                      radius: 20,
                                                                    );
                                                                  }
                                                                }),

                                                            Padding(
                                                                padding: EdgeInsets.all(10)
                                                            ),


                                                            Column(
                                                              children: <Widget>[
                                                                //comment profile name
                                                                (FirebaseAuth.instance.currentUser == null)?
                                                                Container(
                                                                  constraints: BoxConstraints(
                                                                      maxWidth: MediaQuery.of(context).size.width * 0.7
                                                                  ),
                                                                  child: Text('${snapshot.data?.docs[index]['displayName']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, overflow: TextOverflow.ellipsis ),maxLines: 1,),
                                                                )
                                                                    : StreamBuilder<DocumentSnapshot>(
                                                                    stream: FirebaseFirestore.instance.collection('UserName').doc('${snapshot.data!.docs[index]['email']}').snapshots(),
                                                                    builder: (context, Namesnapshot){
                                                                      if (!Namesnapshot.data!.exists){
                                                                        return Container(
                                                                          constraints: BoxConstraints(
                                                                              maxWidth: MediaQuery.of(context).size.width * 0.7
                                                                          ),
                                                                          child: Text('Anonymous User', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, overflow: TextOverflow.ellipsis ),maxLines: 1,),
                                                                        );
                                                                      }
                                                                      else{
                                                                        return  Container(
                                                                          constraints: BoxConstraints(
                                                                              maxWidth: MediaQuery.of(context).size.width * 0.7
                                                                          ),
                                                                          child: Text('${Namesnapshot.data!['name']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, overflow: TextOverflow.ellipsis ),maxLines: 1,),
                                                                        );
                                                                      }
                                                                    }),


                                                                Padding(padding: EdgeInsets.only(top: 10)),

                                                                Container(
                                                                    constraints: BoxConstraints(
                                                                        maxWidth: MediaQuery.of(context).size.width * 0.7
                                                                    ),
                                                                    child: Text('${snapshot.data?.docs[index]['comment']}', style: TextStyle(fontSize: 16, height: 1.4), )
                                                                ),
                                                                Padding(padding: EdgeInsets.only(top: 10)),

                                                                Text('${snapshot.data?.docs[index]['displayDate']}', style: TextStyle(color: Colors.grey))
                                                              ],
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                            )
                                                          ],
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                        )

                                                    );
                                                  });

                                            }
                                        ),

                                      ],
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                    ))
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: 60)
                            )
                          ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      )))
          );
        }
    ));
  }
}
