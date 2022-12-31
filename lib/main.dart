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
  List<String> docId = [];

  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('Customers')
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docId.add(document.reference.id);
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    getDocId();
    print(docId.length);
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
              itemCount: docId.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      tileColor: Colors.grey,
                      title: GetUserName(
                        documentId: docId[index],
                      )),
                );
              });
        },
      )),
    ));
  }
}





// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: const MyHomePage(),
// //     );
// //   }
// // }

// // class MyHomePage extends StatefulWidget {
// //   const MyHomePage({Key? key}) : super(key: key);

// //   @override
// //   State<MyHomePage> createState() => _MyHomePageState();
// // }

// // class _MyHomePageState extends State<MyHomePage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Flutter Firebase'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: <Widget>[
// //             const Image(
// //               width: 300,
// //               height: 300,
// //               image: NetworkImage(
// //                   'https://seeklogo.com/images/F/firebase-logo-402F407EE0-seeklogo.com.png'),
// //             ),
// //             const SizedBox(
// //               height: 30,
// //             ),
// //             const Text(
// //               'Firebase Realtime Database Series in Flutter 2022',
// //               style: TextStyle(
// //                 fontSize: 24,
// //                 fontWeight: FontWeight.w500,
// //               ),
// //               textAlign: TextAlign.center,
// //             ),
// //             const SizedBox(
// //               height: 30,
// //             ),

// //             const SizedBox(
// //               height: 30,
// //             ),
// //             MaterialButton(
// //               onPressed: () {
// //                 Navigator.push(context,
// //                     MaterialPageRoute(builder: (context) => const FetchData()));
// //               },
// //               child: const Text('Fetch Data'),
// //               color: Colors.blue,
// //               textColor: Colors.white,
// //               minWidth: 300,
// //               height: 40,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';

// // CollectionReference Customers =
// //     FirebaseFirestore.instance.collection('Customers');

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp( home:FetchData());
//   }
// }


// class FetchData extends StatefulWidget {
//   const FetchData({super.key});

//   @override
//   State<FetchData> createState() => _FetchDataState();
// }

// class _FetchDataState extends State<FetchData> {
//   Query dbRef = FirebaseDatabase.instance.ref().child('Customers');
//   DatabaseReference reference =
//       FirebaseDatabase.instance.ref().child('Customers');
//   Widget ListItem({required Map customers}) {
//     return Container(
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(10),
//       height: 100,
//       color: Colors.amber,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             customers['name'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             customers['phone'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             customers['time&date'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//       appBar: AppBar(title: Text(" User Data ")),
//       body: Container(
//         height: double.infinity,
//         child: FirebaseAnimatedList(
//           query: dbRef,
//           itemBuilder: (BuildContext context, DataSnapshot snapshot,
//               Animation<double> animation, int index) {
//             Map customers = snapshot.value as Map;
//             customers['key'] = snapshot.key;

//             return ListItem(customers: customers);
//           },
//         ),
//       ),
//     ));
//   }
// }




