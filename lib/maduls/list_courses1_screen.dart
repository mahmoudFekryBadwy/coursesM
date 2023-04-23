import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursesm/maduls/play_video_screeen.dart';
import 'package:flutter/material.dart';

class ListCourses1Screen extends StatefulWidget {
  final docid;
  final name;
  final code;
  const ListCourses1Screen({Key? key,this.docid,this.name,this.code}) : super(key: key);

  @override
  State<ListCourses1Screen> createState() => _ListCourses1ScreenState();
}

class _ListCourses1ScreenState extends State<ListCourses1Screen> {

  @override
  Widget build(BuildContext context) {
    CollectionReference videos = FirebaseFirestore.instance.collection(widget.name).doc(widget.docid).collection('videos');
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        foregroundColor: Color(0xFF4097a6),
      ),
         body: Container(
           color: Color(0xFF4097a6),
           child: Column(
             children: [
               Stack(
                 children: [
                   Container(
                     padding: const EdgeInsets.only(top: 30),
                     width: double.infinity,
                     height: 200,
                     decoration: const BoxDecoration(
                         borderRadius: BorderRadius.only(
                             bottomLeft: Radius.circular(40),bottomRight:Radius.circular(40)
                         ),
                         color: Colors.white
                     ),
                     child: Column(
                       children: const [
                         Image(image: AssetImage('assets/images/camera.png'),height: 100,width: 100,),

                         SizedBox(height: 30,),
                       ],
                     ),
                   ),
                   Container(
                     padding: EdgeInsets.only(left: 290,top: 160),
                     child: const CircleAvatar(
                       maxRadius: 39,
                       backgroundColor: Color(0xFF4097a6),
                       child: CircleAvatar(
                         maxRadius: 35,
                         backgroundColor: Colors.white,
                         child: Image(image: AssetImage('assets/images/play.png'),width: 40,height: 40,),
                       ),
                     ),
                   ),
                 ],
               ),
               Expanded(child: FutureBuilder(
                 future: videos.orderBy("num", descending: false).get(),
                 builder: (context, snapshot) {
                   if (snapshot.hasData) {
                     return ListView.builder(
                         itemCount: snapshot.data!.docs.length,
                         itemBuilder: (context, i) {
                           return InkWell(
                             onTap: () async {
                               print(widget.code.toString());
                               Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PlayVideoScreen(
                                 list: (snapshot.data!.docs[i].data() as Map)['video'],
                                 name: (snapshot.data!.docs[i].data() as Map)['name'],
                                 code: widget.code,
                               )));
                             },
                             child: Card(
                               elevation: 10,
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(20)),
                               child: Container(
                                 width: double.infinity,
                                 height: 60,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
                                   children: [
                                     Expanded(child: Container(
                                       padding: EdgeInsets.only(left: 20),
                                       child: Text(
                                         "0${(snapshot.data!.docs[i].data() as Map)['num']}",
                                         style: const TextStyle(
                                           fontWeight:
                                           FontWeight.bold,
                                           fontSize: 20,
                                         ),
                                         textAlign: TextAlign.start,
                                       ),
                                     ),),
                                     Expanded(child: Container(
                                       child: Text(
                                         (snapshot.data!.docs[i].data() as Map)['name'],
                                         style: const TextStyle(
                                           fontWeight:
                                           FontWeight.bold,
                                           fontSize: 20,
                                         ),
                                         textAlign: TextAlign.center,
                                         textDirection: TextDirection.rtl,
                                         maxLines: 3,
                                       ),
                                     ),),
                                     Expanded(child: Container(
                                       alignment: Alignment.centerRight,
                                       padding: EdgeInsets.only(right: 10),
                                       child: Icon(Icons.play_arrow,size: 50,),
                                     ),),

                                   ],
                                 ),
                               ),
                             ),
                           );
                         });
                   }
                   if (snapshot.hasError) {
                     return const Text('Error');
                   }
                   return const Center(
                     child: CircularProgressIndicator(),
                   );
                 },
               ),),
             ],
           ),
         ),
    );
  }
}
