import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/tools/drawer.dart';
import 'package:untitled/tools/forumWriting.dart';

import 'home.dart';

class ForumView extends StatefulWidget {
  const ForumView({Key? key}) : super(key: key);

  @override
  _ForumViewState createState() => _ForumViewState();
}

class _ForumViewState extends State<ForumView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: MediaQuery.of(context).size.height *0.09,
        iconTheme: const IconThemeData(color:Colors.grey),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset('image/logo.jpg', fit: BoxFit.fitHeight, height: 55),
        actions: [
          GestureDetector(
            onTap:() {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()));
            },
            child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015)),
                  Icon(Icons.book_outlined, size: MediaQuery.of(context).size.height * 0.035),
                  Text('   App\nManual',style: TextStyle(color: Colors.black54, fontSize: 10),)]),),
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
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Text('General Forum', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),)),
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
                        return SizedBox(child: Card(
                            child: Row(
                              children: <Widget> [
                                Padding(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03, top: MediaQuery.of(context).size.width *0.03),
                                  child: SizedBox(
                                  width: MediaQuery.of(context).size.height *0.15,
                                  height: MediaQuery.of(context).size.height * 0.15,
                            child: Image.network('${snapshot.data!.docs[index]['imageUrl']}', fit: BoxFit.cover),),),

                                Column(children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.02, top: MediaQuery.of(context).size.height * 0.02),
                                      child: Text('${snapshot.data!.docs[index]['title']}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.01),
                                      child:  Text('${snapshot.data!.docs[index]['displayDate']}', style: TextStyle(fontSize: 13),)
                                  )
                                ],)

                              ],
                              crossAxisAlignment: CrossAxisAlignment.start,
                            ),
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
        )
    );
  }
}
