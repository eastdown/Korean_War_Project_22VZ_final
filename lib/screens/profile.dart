import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/tools/drawer.dart';

import 'home.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker profilepicker = ImagePicker();
  late File _profileimage;

  Future _getImage() async {
    final pickedFile = await profilepicker.pickImage(
      source: ImageSource.gallery,);
    // 사진의 크기를 지정 650*100 이유: firebase는 유료이다.
    setState(() {
      _profileimage = File(pickedFile!.path);
    });
  }
  Future _uploadFile(BuildContext context) async {
    try {


      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('profilePhoto')   //'post'라는 folder를 만들고
          .child('${DateTime.now().millisecondsSinceEpoch}.png');

      // 파일 업로드
      final uploadTask = firebaseStorageRef.putFile(
          _profileimage, SettableMetadata(contentType: 'image/png'));

      // 완료까지 기다림
      await uploadTask.whenComplete(() => null);

      // 업로드 완료 후 url
      final downloadUrl = await firebaseStorageRef.getDownloadURL();

      // 문서 작성
      await FirebaseFirestore.instance.collection('UserImage').doc('${FirebaseAuth.instance.currentUser?.email}').set({
        'image': downloadUrl,
      });
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    String userName = '';

    return Scaffold(
      appBar: AppBar(
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
      body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('UserImage').doc('${FirebaseAuth.instance.currentUser?.email}').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return CircularProgressIndicator();
            }
            else if (snapshot.data!.exists){
              return Column(children: <Widget>[
              Align(
              alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text('Profile', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                ),),
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Stack(children: <Widget>[
                          CircleAvatar(
                              radius: 100,
                              child: SizedBox(
                                width: 200,
                                  height: 200,
                                  child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                  child: Image.network('${snapshot.data!['image']}', fit: BoxFit.cover))
                          ),),
                          Align(
                              alignment: Alignment.bottomRight,
                              child: FloatingActionButton(onPressed: () async {
                                await _getImage().then((value) {
                                  _uploadFile(context);
                                });
                                },
                                  child: Icon(Icons.image_outlined)))
                        ]

            )))

              ]);
            } else {
              return Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 8, top: 10),
                        child: Text('Profile', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      ),),
                    Align(
                alignment: Alignment.center,
                  child: SizedBox(
                    width: 200,
                      height: 200,
                      child: Stack(children:
                  <Widget>[
                    CircleAvatar(
                        radius: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',)
                        )
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                        child: FloatingActionButton(onPressed: () async {
                        await _getImage().then((value) {
                        _uploadFile(context);
                        });
                        },
                        child: Icon(Icons.image_outlined))),


                  ]

                  ))),
                    StreamBuilder<DocumentSnapshot>(
                          stream: FirebaseFirestore.instance.collection('UserName').doc('${FirebaseAuth.instance.currentUser?.email}').snapshots(),
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
                              return Text('${snapshot.data!['name']}', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold));
                            }
                          }),
                    OutlinedButton(
                      onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Write New Name'),
                          content: TextField(controller: nameController,),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                FirebaseFirestore.instance.collection('UserName').doc('${FirebaseAuth.instance.currentUser?.email}').set({
                                  'name': nameController.text,
                                });
                                Navigator.pop(context, 'OK');},
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      ),
                      child: const Text('Change Name'),
                    ),
                    Text('${FirebaseAuth.instance.currentUser?.email}'),


                  ],
              );
            }

          }
          ),
    );
  }
}
