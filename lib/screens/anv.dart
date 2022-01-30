import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

          return ScreenUtilInit(
              designSize: Size(390, 763),

              builder: () => Scaffold(
              appBar: AppBar(
                  elevation: 0,
                  iconTheme: const IconThemeData(color: Colors.grey),
                  backgroundColor: Colors.white,
                  centerTitle: true,
                  title: Text(snapshot.data!.docs[currentIndex]['title'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
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
                        child:Text(snapshot.data!.docs[currentIndex]['article'].replaceAll("\\n", "\n"), style: TextStyle(height: 1.6.h, fontSize:20.sp,))
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 50.sp)
                    )
                  ]
              )))
          ));
        }
    );
  }
}