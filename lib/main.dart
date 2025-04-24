// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:karim_pay/Screens/application_screen.dart';
// import 'package:karim_pay/Screens/application_screen2.dart';
// import 'package:karim_pay/Screens/application_submission.dart';
// import 'package:karim_pay/Screens/edit_profile.dart';
// import 'package:karim_pay/Screens/forgot_password_screen.dart';
// import 'package:karim_pay/Screens/home_screen.dart';
// import 'package:karim_pay/Screens/logIn_screen.dart';
// import 'package:karim_pay/Screens/profile_update.dart';
// import 'package:karim_pay/Screens/signUp_screen.dart';
// import 'package:karim_pay/Screens/splash_screen1.dart';
// import 'package:karim_pay/Screens/splash_screen2.dart';

// import 'package:sizer/sizer.dart';

// import 'firebase_options.dart';

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(builder: (context, orientation, screeType){
//       return MaterialApp(
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           // This is the theme of your application.
//           //
//           // TRY THIS: Try running your application with "flutter run". You'll see
//           // the application has a purple toolbar. Then, without quitting the app,
//           // try changing the seedColor in the colorScheme below to Colors.green
//           // and then invoke "hot reload" (save your changes or press the "hot
//           // reload" button in a Flutter-supported IDE, or press "r" if you used
//           // the command line to start the app).
//           //
//           // Notice that the counter didn't reset back to zero; the application
//           // state is not lost during the reload. To reset the state, use hot
//           // restart instead.
//           //
//           // This works for code too, not just values: Most code changes can be
//           // tested with just a hot reload.
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: SplashScreen1(),
//         debugShowCheckedModeBanner: false,
//       );
//     });
//   }
// }

// ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:karim_pay/Screens/bottom_nav_bar.dart';
import 'package:karim_pay/Screens/home_screen.dart';
import 'package:karim_pay/Screens/splash_screen2.dart';
import 'package:karim_pay/firebase_options.dart';
import 'package:karim_pay/utilities/globals.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    // Show splash screen for 2 seconds before checking auth state
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: _showSplash
              ? const MainSplash()
              : StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const MainSplash(); // Loading UI
                    } else if (snapshot.hasData) {
                      final user = snapshot.data!;
                      final userId = user.uid;

                      // Fetch flag from Firestore
                      return FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const MainSplash(); // Optional: show loading while fetching flag
                          } else if (snapshot.hasError ||
                              !snapshot.hasData ||
                              !snapshot.data!.exists) {
                            return const Text("Error loading user data.");
                          }

                          final data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          final bool policyVerified =
                              data['policyverification'] == true;

                          return BottomNavBar(flag: policyVerified);
                        },
                      );
                    } else {
                      return SplashScreen2(); // User not signed in
                    }
                  },
                ),
        );
      },
    );
  }
}

class MainSplash extends StatelessWidget {
  const MainSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo.png'),
        ),
      ),
    );
  }
}
