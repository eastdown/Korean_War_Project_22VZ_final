import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/screens/forumView.dart';
import 'home.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:intl/intl.dart';

class AnvPage extends StatefulWidget {
  const AnvPage({Key? key}) : super(key: key);

  @override
  _AnvPageState createState() => _AnvPageState();
}

class _AnvPageState extends State<AnvPage> {
  String? comment;
  TextEditingController commentController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  String? postID;

  final Stream<QuerySnapshot> adv = FirebaseFirestore.instance.collection('ArticlesAndVideo').snapshots();

  @override
  Widget build(BuildContext context) {
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




    return  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ArticlesAndVideo').orderBy('docNum', descending: true).snapshots(),
        builder: (context, snapshot) {
          postID = '${snapshot.data?.docs[currentIndex].id}';
          String url = '${snapshot.data?.docs[currentIndex]['video']}';
          YoutubePlayerController _controller = YoutubePlayerController(
            initialVideoId: "${YoutubePlayer.convertUrlToId(url)}",
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          );

          return ScreenUtilInit(
              designSize: Size(390, 763),

              builder: () => Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                      elevation: 0,
                      iconTheme: const IconThemeData(color: Colors.grey),
                      backgroundColor: Colors.white,
                      centerTitle: true,
                      title: Text(snapshot.data?.docs[currentIndex]['title'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                  ),
                  body: SingleChildScrollView(
                      child: ConstrainedBox(
                          constraints: BoxConstraints(),
                          child: Column(
                              children: <Widget>[

                                YoutubePlayer(
                                  controller: _controller,
                                  showVideoProgressIndicator: true,
                                ),

                                Padding(
                                    padding: EdgeInsets.only(left:15.sp, right: 15.sp, top: 10.sp),
                                    child:Text(snapshot.data?.docs[currentIndex]['article'].replaceAll("\\n", "\n"), style: TextStyle(height: 1.6.h, fontSize:20.sp,))
                                ),

                                Padding(
                                    padding: EdgeInsets.only(bottom: 30.sp)
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
                                                (FirebaseAuth.instance.currentUser != null)?
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
                                                    }):  Padding(padding: EdgeInsets.only(left: 15.sp, right: 10.sp),
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

                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [



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
                                                                    FirebaseFirestore.instance.collection('ArticlesAndVideo').doc(postID).collection('comment').doc().set({
                                                                      'comment' : commentController.text,
                                                                      'displayName': (FirebaseAuth.instance.currentUser != null) ? "${FirebaseAuth.instance.currentUser?.displayName}": nameController.text,
                                                                      'email': "${FirebaseAuth.instance.currentUser?.email}",
                                                                      'userImage': (FirebaseAuth.instance.currentUser != null) ? "${FirebaseAuth.instance.currentUser?.photoURL}":'https://firebasestorage.googleapis.com/v0/b/vz--korean-war-project.appspot.com/o/profilePhoto%2FSampleProfile.jpeg?alt=media&token=b19d872b-b906-4fe9-bc69-1e779ee6aa79',
                                                                      'date': DateTime.now().toUtc(),
                                                                      'displayDate' : DateFormat.yMMMd('en_US').format(DateTime.now()),
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
                                                        )],
                                                    ),
                                                  ],
                                                ),

                                                Padding(padding: EdgeInsets.only(left:15.sp))
                                              ],

                                            ),
                                      StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance.collection('ArticlesAndVideo').doc(postID).collection('comment').orderBy("date", descending: true).snapshots(),
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
                                                          CircleAvatar(
                                                            backgroundImage: NetworkImage('${snapshot.data?.docs[index]['userImage']}'),
                                                            radius: 20,
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets.all(10)
                                                          ),
                                                          Column(
                                                            children: <Widget>[

                                                             Container(
                                                               constraints: BoxConstraints(
                                                                   maxWidth: MediaQuery.of(context).size.width * 0.7
                                                               ),
                                                               child: Text('${snapshot.data?.docs[index]['displayName']}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),overflow: TextOverflow.ellipsis,),
                                                             ),
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
                                )
                              ]
                          )))
              ));
        }
    );
  }
}