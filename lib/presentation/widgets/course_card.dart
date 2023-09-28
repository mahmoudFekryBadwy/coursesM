import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coursesm/core/services/db_helper.dart';
import 'package:coursesm/core/utils/enums/courses_type.dart';
import 'package:coursesm/data/models/course_model.dart';
import 'package:flutter/material.dart';

import '../course_videos/list_courses1_screen.dart';

class CourseCard extends StatelessWidget {
  final CourseModel course;
  final CoursesType coursesType;
  const CourseCard(
      {super.key, required this.course, required this.coursesType});

  @override
  Widget build(BuildContext context) {
    var codeId;
    var uId;
    var codeController = TextEditingController();
    var code;
    return InkWell(
      onTap: ()async {
        CollectionReference codes = FirebaseFirestore
              .instance
              .collection(coursesType.name.toString())
              .doc(course.id)
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
                      course: course,
                      coursesType: coursesType,
                      code: DBHelper.idToken.first.toString(),
                    )));
          } else {
            // ignore: use_build_context_synchronously
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
                                  .collection(coursesType.name.toString())
                                  .doc(course.id)
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
                                              course: course,
                          coursesType: coursesType,
                                              code: '3mDoneCode',
                                            )));
                                codes
                                    .doc(codeId['uid'])
                                    .set({
                                  "code":
                                      "${codeId['code']}3mDoneCode",
                                  "uid": "${codeId['uid']}"
                                }, SetOptions(merge: true));
                                codes.doc(listcode[uId].id).delete();
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
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: (context) => ListCourses1Screen(
        //           course: course,
        //           coursesType: coursesType,
        //           code: '3mDoneCode',
        //         )));
      },
      // onTap: () async {
      //   CollectionReference codes = FirebaseFirestore
      //       .instance
      //       .collection("courses2")
      //       .doc(course.id)
      //       .collection('codes');
      //   QuerySnapshot codeSnapshot = await codes.get();
      //   List<QueryDocumentSnapshot> listcode =
      //       codeSnapshot.docs;
      //   for (var code in listcode) {
      //     codeId = (code.data());
      //     uId = codeId['uid'];
      //     print(uId);
      //   }
      //   if (DBHelper.idToken.contains(codeId['uid'])) {
      //     Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => ListCourses1Screen(
      //               course: course,
      //                   coursesType: coursesType,
      //
      //               code:
      //                   DBHelper.idToken.first.toString(),
      //             )));
      //   } else {
      //     showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             title: const Text('Enter Your Code'),
      //             content: TextFormField(
      //               controller: codeController,
      //               onSaved: (val) {
      //                 code = val;
      //               },
      //               validator: (val) {
      //                 if (val!.length > 100) {
      //                   return "Password can't to be larger than 100 letter";
      //                 }
      //                 if (val.length < 4) {
      //                   return "Password can't to be less than 4 letter";
      //                 }
      //                 return null;
      //               },
      //               obscureText: true,
      //               decoration: const InputDecoration(
      //                   prefixIcon: Icon(Icons.lock),
      //                   hintText: "Code",
      //                   border: OutlineInputBorder(
      //                       borderSide:
      //                           BorderSide(width: 1))),
      //             ),
      //             actions: [
      //               Center(
      //                   child: ElevatedButton(
      //                 onPressed: () async {
      //                   CollectionReference codes =
      //                       FirebaseFirestore.instance
      //                           .collection("courses2")
      //                           .doc(snapshot
      //                               .data!.docs[i].id)
      //                           .collection('codes');
      //                   QuerySnapshot codeSnapshot =
      //                       await codes.get();
      //                   List<QueryDocumentSnapshot>
      //                       listcode = codeSnapshot.docs;
      //                   for (var code in listcode) {
      //                     codeId = (code.data());
      //                     print(uId);
      //                     if (codeId['code'] ==
      //                         codeController.text) {
      //                       DBHelper.insertDatabase(
      //                         uid: uId,
      //                       ).then((value) {
      //                         codeController.clear();
      //                         Navigator.of(context).push(
      //                             MaterialPageRoute(
      //                                 builder: (context) =>
      //                                     ListCourses1Screen(
      //                                       course: course,
      //                   coursesType: coursesType,
      //                   code: '3mDoneCode',
      //                                       code: DBHelper
      //                                           .idToken
      //                                           .first
      //                                           .toString(),
      //                                     )));
      //                         codes
      //                             .doc(codeId['uid'])
      //                             .set({
      //                           "code":
      //                               "${codeId['code']}3mDoneCode",
      //                           "uid": "${codeId['uid']}"
      //                         }, SetOptions(merge: true));
      //                         codes
      //                             .doc(listcode[codeId[i]]
      //                                 .id)
      //                             .delete();
      //                       });
      //                     }
      //                   }
      //                 },
      //                 child: Text(
      //                   "Enter",
      //                   style: Theme.of(context)
      //                       .textTheme
      //                       .titleLarge,
      //                 ),
      //               )),
      //             ],
      //           );
      //         });
      //   }
      // },
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    course.name!,
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
  }
}
