
import 'package:auth_buttons/auth_buttons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(  const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[100],
      child: Center(
        child: GoogleAuthButton(
          onPressed: () async {
              GoogleSignInAccount? googleSignInAccount= await _googleSignIn.signIn();
              GoogleSignInAuthentication googleSignInAuthentication=await googleSignInAccount!.authentication;
              AuthCredential credential= GoogleAuthProvider.credential(
                idToken: googleSignInAuthentication.idToken,
                accessToken: googleSignInAuthentication.accessToken
              );
              await _auth.signInWithCredential(credential).whenComplete((){
                print("complete");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Homepage1()),
                );
              });


            // FirebaseAuth _auth = FirebaseAuth.instance;
            // await _auth.signInWithEmailAndPassword(email: "ankit@gmail.com", password: "1234@Avfd").whenComplete((){
            //   print("signin password");
            // });



              // await _auth.createUserWithEmailAndPassword(
              //   email: "viashal@gmail.com",
              //   password: "1234@Avfd",
              // ).whenComplete((){ print("register user"); });
          },
          //child: const Text("add"),
        ),
      ),
    );
  }
}


// class AuthenticationHelper {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   get user => _auth.currentUser;
//
//   //SIGN UP METHOD
//   Future signUp({required String email, required String password}) async {
//     try {
//       await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }
//
//   //SIGN IN METHOD
//   Future signIn({required String email, required String password}) async {
//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }
//
//   //SIGN OUT METHOD
//   Future signOut() async {
//     await _auth.signOut();
//
//     print('signout');
//   }
// }
//
//


class Homepage1 extends StatefulWidget {
  const Homepage1({Key? key}) : super(key: key);

  @override
  _Homepage1State createState() => _Homepage1State();
}

class _Homepage1State extends State<Homepage1> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color: Colors.yellow[100],
        child: Center(
          child: Text("This is Home page"),
        ),
      ),
    );
  }
}



