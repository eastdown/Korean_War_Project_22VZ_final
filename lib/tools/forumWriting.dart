import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ForumWriting extends StatefulWidget {
  const ForumWriting({Key? key}) : super(key: key);

  @override
  _ForumWritingState createState() => _ForumWritingState();
}

class _ForumWritingState extends State<ForumWriting> {
  final ImagePicker picker = ImagePicker();
  late File _image;

  bool uploading = false;


  FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();


  String postTitle = '';
  String content = '';
  String downloadUrl = 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.shutterstock.com%2Fimage-vector%2Fsample-stamp-square-grunge-sign-1474408826&psig=AOvVaw0pFdsD0BzttQ-lAweAdt6G&ust=1642921398528000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCKiw7KTlxPUCFQAAAAAdAAAAABAD';


  Future _getImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,);
    // 사진의 크기를 지정 650*100 이유: firebase는 유료이다.
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

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

      // 문서 작성

    } catch (e) {
      print(e);
    }

    // 완료 후 앞 화면으로 이동
    Navigator.pop(context);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Posting')),
        body: Container(
            child: Column(
              children: <Widget>[
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
                  Navigator.pop(context);

                  FirebaseFirestore.instance.collection('Forum').doc().set({
                    'title': postTitle,
                    'content': content,
                    'displayName': "${FirebaseAuth.instance.currentUser?.displayName}",
                    'email': "${FirebaseAuth.instance.currentUser?.email}",
                    'photoUrl': downloadUrl,
                  });
                },
                    child: Text('Post'))
              ],
            )
        ));
  }
}
