import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

class AnvPage extends StatefulWidget {
  const AnvPage({Key? key}) : super(key: key);

  @override
  _AnvPageState createState() => _AnvPageState();
}

class _AnvPageState extends State<AnvPage> {

  final Stream<QuerySnapshot> adv = FirebaseFirestore.instance.collection('ArticlesAndVideo').snapshots();

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('ArticlesAndVideo').snapshots(),
    builder: (context, snapshot) {
      
      String url = '${snapshot.data!.docs[currentIndex]['video']}';
      YoutubePlayerController _controller = YoutubePlayerController(
        initialVideoId: "${YoutubePlayer.convertUrlToId(url)}",
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
      
      return Scaffold(
        appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.grey),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(snapshot.data!.docs[currentIndex]['title'], style: TextStyle(color: Colors.black))
        ),
        body: Colum(
          children: <Widget>[
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
            Text(snapshot.data!.docs[currentIndex]['article']),
          ]
        )
      );
    }
      );
  }
}
