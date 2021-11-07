import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'forumView.dart';

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Forum').orderBy("date", descending: true).snapshots(),
        builder: (context, snapshot) {

          return Scaffold(
            backgroundColor: Colors.white,
              appBar: AppBar(
                  elevation: 0,
                  iconTheme: const IconThemeData(color: Colors.grey),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                title: Text('Post', style: TextStyle(color: Colors.black))
              ),
              body: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(),
                      child: Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.08, right: MediaQuery.of(context).size.width * 0.08, top: 10, bottom: 10),
                                child:Text(snapshot.data!.docs[postIndex]['title'], style: TextStyle(height: 1.6, fontSize:30,fontWeight: FontWeight.bold))
                            ),
                            Row(
                              children: <Widget>[
                                StreamBuilder<DocumentSnapshot>(
                                    stream: FirebaseFirestore.instance.collection('UserImage').doc('${snapshot.data!.docs[postIndex]['email']}').snapshots(),
                                    builder: (context, snapshot){
                                      if (snapshot.connectionState == ConnectionState.waiting){
                                        return Divider();
                                      }
                                      else if (!snapshot.data!.exists){
                                        return Padding(
                                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.02),
                                            child: Text('User Name', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));
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
                                            borderRadius: BorderRadius.all( Radius.circular(50.0)),
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
                                      else if (!snapshot.data!.exists){
                                        return Padding(
                                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.02),
                                            child: Text('User Name', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)));
                                      }
                                      else{
                                        return Padding(
                                            padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.02),
                                            child: Text('${snapshot.data!['name']}', style: TextStyle(fontSize: 15))
                                        );
                                      }
                                    }),
                              ],
                            ),

                            Padding(
                                padding: EdgeInsets.only(left:MediaQuery.of(context).size.width * 0.08, right: 15, top: 5),
                                child:Text(snapshot.data!.docs[postIndex]['displayDate'], style: TextStyle(height: 1.6, fontSize:15))
                            ),


                            Padding(
                                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08, right: MediaQuery.of(context).size.width * 0.08, top: MediaQuery.of(context).size.height * 0.04),
                                child:Text(snapshot.data!.docs[postIndex]['content'].replaceAll("\\n", "\n"), style: TextStyle(height: 1.6, fontSize:20,))
                            ),

                            Padding(
                                padding: EdgeInsets.only(bottom: 50)
                            ),
                          ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      )))
          );
        }
    );
  }
}
