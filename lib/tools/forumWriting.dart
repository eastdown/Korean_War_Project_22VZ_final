import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ForumWriting extends StatefulWidget {
  const ForumWriting({Key? key}) : super(key: key);

  @override
  _ForumWritingState createState() => _ForumWritingState();
}

class _ForumWritingState extends State<ForumWriting> {

  bool uploading = false;


  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();


  String postTitle = '';
  String content = '';

  String downloadUrl ='';
  final ImagePicker picker = ImagePicker();
  var _image;

  Future _getImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cannot Post Your Writing'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please fill out both title and content'),
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




  @override
  Widget build(BuildContext context) {




    Future _uploadFile(BuildContext context) async {
      try {


        final firebaseStorageRef = FirebaseStorage.instance
            .ref()
            .child('post')   //'post'라는 folder를 만들고
            .child('${DateTime.now().millisecondsSinceEpoch}.png');

        // 파일 업로드
        final uploadTask = firebaseStorageRef.putFile(
            _image, SettableMetadata(contentType: 'image/png'));

        // 완료까지 기다림
        await uploadTask.whenComplete(() => null);

        // 업로드 완료 후 url
        downloadUrl = await firebaseStorageRef.getDownloadURL();

        await FirebaseFirestore.instance.collection('Forum').doc().set({
          'title': postTitle,
          'content': content,
          'displayName': "${FirebaseAuth.instance.currentUser?.displayName}",
          'email': "${FirebaseAuth.instance.currentUser?.email}",
          'imageUrl': downloadUrl,
          'date': DateTime.now(),
          'displayDate' : DateFormat.yMMMMd('en_US').format(DateTime.now().toUtc()) + '  UTC'
        });


        // 문서 작성

      } catch (e) {
        print(e);
      }

    }

    Future _imageMethod() async{
      try {
        _getImage();
        await _uploadFile(context);
      } catch (e) {
        print(e);
      }
    }


    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Posting', style: TextStyle(color: Colors.black87),),
          iconTheme: IconThemeData(color: Colors.grey),
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          elevation: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              children: <Widget>[
                Container(
                  child: GestureDetector(
                    onTap: _getImage,
                    child: Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: Icon(Icons.image_outlined, size: 40)
                ),),),
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05, ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: GestureDetector(
                    onTap: (){
                      if (_image != null && titleController.text != '' && contentController.text != '') {
                        _uploadFile(context);
                        Navigator.pop(context);

                      } else if (titleController.text == '' && contentController.text != ''){
                        _showMyDialog();
                      } else if (titleController.text != '' && contentController.text == ''){
                        _showMyDialog();
                      } else if (titleController.text == '' && contentController.text == ''){
                        _showMyDialog();
                      }
                      else {
                        FirebaseFirestore.instance.collection('Forum').doc().set({
                          'title': postTitle,
                          'content': content,
                          'displayName': "${FirebaseAuth.instance.currentUser?.displayName}",
                          'email': "${FirebaseAuth.instance.currentUser?.email}",
                          'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/vz--korean-war-project.appspot.com/o/profilePhoto%2FSampleProfile.jpeg?alt=media&token=b19d872b-b906-4fe9-bc69-1e779ee6aa79',
                          'date': DateTime.now().toUtc(),
                          'displayDate' : DateFormat.yMMMMd('en_US').format(DateTime.now().toUtc()) + '  UTC'
                        });
                        Navigator.pop(context);

                      }

                    },
                    child: Center(child: Text('Submit', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15),),),
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(121, 179, 119, 1.0),
                    borderRadius: BorderRadius.circular(20)
                  ),
                )),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            )
          )
        ),



        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.02, left: MediaQuery.of(context).size.width *0.03),
                    child: Text('Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
                ),
                Padding(
                  padding: EdgeInsets.only( left: MediaQuery.of(context).size.width *0.03, right:MediaQuery.of(context).size.width *0.03 ),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        labelText: 'Add a title here'
                    ),
                    onChanged: (value){
                      setState(() {
                        postTitle = value;
                      });
                    },
                  ),
                ),

                Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height *0.05, left: MediaQuery.of(context).size.width *0.03),
                    child: Text('Content', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
                ),
                Padding(
                  padding: EdgeInsets.only( left: MediaQuery.of(context).size.width *0.03, right:MediaQuery.of(context).size.width *0.03 ),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: contentController,
                    decoration: InputDecoration(
                        labelText: 'Add your content here',
                    ),
                    maxLines: null,
                    onChanged: (value){
                      setState(() {
                        content = value;
                      });
                    },
                  ),
                ),

                _image == null ? Padding(padding: EdgeInsets.only(top: 20)) :
                Padding(padding: EdgeInsets.all(MediaQuery.of(context).size.width *0.04,),
                child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width *0.9,
                        height: MediaQuery.of(context).size.height *0.15,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(175, 175, 175, 1.0),
                        ),
                        child: Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *0.25,
                                      height: MediaQuery.of(context).size.width *0.25,
                                      child: Image.file(_image, fit: BoxFit.cover),
                                    ),
                                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03)
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.01,
                                  ),
                                  child: Text('Image Selected', style: TextStyle(fontSize: 18, color: Colors.white),),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width *0.01,
                              ),
                              child: TextButton(
                                onPressed: (){
                                  setState(() {
                                    _image = null;
                                  });
                                },
                                child: Icon(Icons.delete, size: 30, color: Colors.white),
                              )
                            ),


                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        )
                    )
                )

                )




              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )
        ));
  }
}
