import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// class GetUserName extends StatelessWidget {
//   // const GetUserName({super.key});
//   final String documentId;

//   GetUserName({required this.documentId});

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference customer =
//         FirebaseFirestore.instance.collection('Customers');
//     return FutureBuilder<DocumentSnapshot>(
//         future: customer.doc(documentId).get(),
//         builder: ((context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic> data =
//                 snapshot.data!.data() as Map<String, dynamic>;
//             Timestamp t = data['time&date'] as Timestamp;
//             DateTime date = t.toDate();
//             // final DateTime date =
//             //     DateTime.fromMillisecondsSinceEpoch(timeNdate * 1000);
//             return Text('\n Sr. : ,' +
//                 '\n Name :  ${data['name']},' +
//                 '\n Phone  :  ${data['phone']},' +
//                 ' \n Time : ${date} ');
//           }
//           return Text('Loading...');
//         }));
//   }
// }
