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
                Text('You did not fill the textfield'),
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
        appBar: AppBar(title: Text('Posting')),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                _image == null ? Text('No image') : Image.file(_image),

                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      border:OutlineInputBorder(),
                      labelText: 'Title'
                  ),
                  onChanged: (value){
                    setState(() {
                      postTitle = value;
                    });
                  },
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: contentController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Content'
                  ),
                  onChanged: (value){
                    setState(() {
                      content = value;
                    });
                  },
                ),
                ElevatedButton(onPressed: _getImage,

                    child: Text('image')),


                ElevatedButton(onPressed: (){
                  var now = new DateTime.now();
                  String formatDate = DateFormat('yy/MM/dd - HH:mm:ss').format(now);

                  if (_image != null && titleController.text != '' && contentController.text != '') {
                    _uploadFile(context);
                    Navigator.pop(context);

                  } else if (titleController.text == '' && contentController.text != ''){
                    _showMyDialog();
                  } else if (titleController.text != '' && contentController == ''){

                  } else if (titleController.text == '' && contentController == ''){

                  }
                  else {
                    FirebaseFirestore.instance.collection('Forum').doc().set({
                      'title': postTitle,
                      'content': content,
                      'displayName': "${FirebaseAuth.instance.currentUser?.displayName}",
                      'email': "${FirebaseAuth.instance.currentUser?.email}",
                      'imageUrl': 'https://firebasestorage.googleapis.com/v0/b/vz--korean-war-project.appspot.com/o/forumSample.PNG?alt=media&token=c0c6b228-465c-4b9e-8f5b-ce5424602fe5',
                      'date': DateTime.now().toUtc(),
                      'displayDate' : DateFormat.yMMMMd('en_US').format(DateTime.now().toUtc()) + '  UTC'
                    });
                    Navigator.pop(context);

                  }



                },
                    child: Text('Post'))
              ],
            )
        ));
  }
}
