import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizup_prototype_1/Login-Signup/Login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(home: Login()));
}

// class UploadImages extends StatelessWidget {
//   const UploadImages({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           InkWell(
//             child: const CircleAvatar(
//               child: CircleAvatar(
//                 radius: 57.5,
//                 backgroundColor: Colors.grey,
//                 backgroundImage: AssetImage('assets/images/avatar.png'),
//               ),
//             ),
//             onTap: () async {
//               final results = await FilePicker.platform.pickFiles(
//                 allowMultiple: false,
//                 type: FileType.image,
//               );
//               if (results == null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("no file was picked")));
//               } else {
//                 final path = results.files.single.path;
//                 const filename = "Yassinov";
//                 FireConnect.uploadAvatar(path!, filename);
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
