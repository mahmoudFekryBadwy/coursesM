import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursesm/core/dependencies.dart';
import 'package:coursesm/presentation/courses/courses_viewmodel.dart';
import 'package:coursesm/presentation/list_courses1_screen.dart';
import 'package:coursesm/services/db_helper.dart';
import 'package:flutter/material.dart';

class Courses2Screen extends StatefulWidget {
  const Courses2Screen({Key? key}) : super(key: key);

  @override
  State<Courses2Screen> createState() => _Courses2ScreenState();
}

class _Courses2ScreenState extends State<Courses2Screen> {
  var code;
  var id;
  List tikenid = [];
  var codeController = TextEditingController();
  var codeId;
  var model;
  var uId;

  @override
  void initState() {
    super.initState();
    sl<CoursesViewModel>().getCourses(2);
  }

  @override
  void dispose() {
    super.dispose();
    sl<CoursesViewModel>().resetState();
  }

  CollectionReference courses2 =
      FirebaseFirestore.instance.collection("courses2");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        foregroundColor: const Color(0xFF4097a6),
      ),
      body: Container(
        color: const Color(0xFF4097a6),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90),
                      bottomRight: Radius.circular(90)),
                  color: Colors.white),
              child: Column(
                children: const [
                  Center(
                    child: Text(
                      'الفرقة الثانية',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                future: courses2.get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        itemExtent: 120,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () async {
                              CollectionReference codes = FirebaseFirestore
                                  .instance
                                  .collection("courses2")
                                  .doc(snapshot.data!.docs[i].id)
                                  .collection('codes');
                              QuerySnapshot codeSnapshot = await codes.get();
                              List<QueryDocumentSnapshot> listcode =
                                  codeSnapshot.docs;
                              for (var code in listcode) {
                                codeId = (code.data());
                                uId = codeId['uid'];
                                print(uId);
                              }
                              if (DBHelper.idToken.contains(codeId['uid'])) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ListCourses1Screen(
                                          docid: snapshot.data!.docs[i].id,
                                          name: "courses2",
                                          code:
                                              DBHelper.idToken.first.toString(),
                                        )));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Enter Your Code'),
                                        content: TextFormField(
                                          controller: codeController,
                                          onSaved: (val) {
                                            code = val;
                                          },
                                          validator: (val) {
                                            if (val!.length > 100) {
                                              return "Password can't to be larger than 100 letter";
                                            }
                                            if (val.length < 4) {
                                              return "Password can't to be less than 4 letter";
                                            }
                                            return null;
                                          },
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.lock),
                                              hintText: "Code",
                                              border: OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(width: 1))),
                                        ),
                                        actions: [
                                          Center(
                                              child: ElevatedButton(
                                            onPressed: () async {
                                              CollectionReference codes =
                                                  FirebaseFirestore.instance
                                                      .collection("courses2")
                                                      .doc(snapshot
                                                          .data!.docs[i].id)
                                                      .collection('codes');
                                              QuerySnapshot codeSnapshot =
                                                  await codes.get();
                                              List<QueryDocumentSnapshot>
                                                  listcode = codeSnapshot.docs;
                                              for (var code in listcode) {
                                                codeId = (code.data());
                                                print(uId);
                                                if (codeId['code'] ==
                                                    codeController.text) {
                                                  DBHelper.insertDatabase(
                                                    uid: uId,
                                                  ).then((value) {
                                                    codeController.clear();
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ListCourses1Screen(
                                                                  docid:
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              i]
                                                                          .id,
                                                                  name:
                                                                      "courses2",
                                                                  code: DBHelper
                                                                      .idToken
                                                                      .first
                                                                      .toString(),
                                                                )));
                                                    codes
                                                        .doc(codeId['uid'])
                                                        .set({
                                                      "code":
                                                          "${codeId['code']}3mDoneCode",
                                                      "uid": "${codeId['uid']}"
                                                    }, SetOptions(merge: true));
                                                    codes
                                                        .doc(listcode[codeId[i]]
                                                            .id)
                                                        .delete();
                                                  });
                                                }
                                              }
                                            },
                                            child: Text(
                                              "Enter",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge,
                                            ),
                                          )),
                                        ],
                                      );
                                    });
                              }
                            },
                            child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: SizedBox(
                                width: double.infinity,
                                height: 120,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 120,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20)),
                                        image: DecorationImage(
                                            image: AssetImage(
                                              'assets/images/img_1.png',
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          (snapshot.data!.docs[i].data()
                                              as Map)['name'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                          textAlign: TextAlign.center,
                                          textDirection: TextDirection.rtl,
                                          maxLines: 3,
                                        ),
                                      ),
                                    ),
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
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
