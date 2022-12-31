import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_db/get_user_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'fetch_data.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

List<String> docId = [];

var count = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: FetchData()),
    );
  }
}

class FetchData extends StatefulWidget {
  const FetchData({super.key});

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  // List<String> docId = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Customers')
        .orderBy('time&date', descending: true)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              // print((docId.length / 2).ceil());
              docId.add(document.reference.id);
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Expanded(
          child: FutureBuilder(
        future: getDocId(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: (docId.length / 2).ceil(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      tileColor: Colors.grey,
                      title: GetUserName(
                        documentId: docId[index],
                        srno: index,
                      )),
                );
              });
        },
      )),
    ));
  }
}

class GetUserName extends StatelessWidget {
  // const GetUserName({super.key});
  final String documentId;
  int srno = 0;

  GetUserName({required this.documentId, required this.srno});

  @override
  Widget build(BuildContext context) {
    CollectionReference customer =
        FirebaseFirestore.instance.collection('Customers');
    return FutureBuilder<DocumentSnapshot>(
        future: customer.doc(documentId).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            Timestamp t = data['time&date'] as Timestamp;
            DateTime date = t.toDate();
            // final DateTime date =
            //     DateTime.fromMillisecondsSinceEpoch(timeNdate * 1000);
            return Text('\n Sr. : ${srno + 1}  ' +
                '\n Name :  ${data['name']},' +
                '\n Phone  :  ${data['phone']},' +
                ' \n Time : ${date} ');
          }
          return Text('Loading...');
        }));
  }
}
