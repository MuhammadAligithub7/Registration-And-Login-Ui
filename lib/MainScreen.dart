import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade100,
      appBar: AppBar(
        title: const Text('Welcome',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.black87),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()  {

            showDialog(context: context, builder: (ctx){
              return AlertDialog(
                title: const  Text('Confirmation !!!'),
                content: const  Text('Do You Want To Logout ?'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.of(ctx).pop();
                  }, child: const Text('No')),
                  TextButton(onPressed: (){
                    Navigator.of(ctx).pop();
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  }, child: const Text('Yes')),
                ],
              );
            }
            );

           },
              icon: const Icon(Icons.logout,color: Colors.black87,size: 30,)),
    ],
      ),
    );
  }
}

