import 'package:firebase_auth/firebase_auth.dart';
import 'package:flogin/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'MainScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SafeArea(child:
              Center(child:
              Text('Login',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.cyan),))),

              const SizedBox(height: 15),
              const CircleAvatar(
                  backgroundImage: AssetImage('images/aa.png'),
                  radius: 160,
                ),

              const SizedBox(height: 15),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),

              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),

              const SizedBox(height: 15),
              ElevatedButton(onPressed: () async {
                var email = emailController.text.trim();
                var password = passwordController.text.trim();

                if(email.isEmpty || password.isEmpty){
                  Fluttertoast.showToast(msg: 'Please Fill All The Fields');
                }

                ProgressDialog progressDialog = ProgressDialog(context,
                    title: const Text('Login'),
                    message: const Text('Please Wait'));
                    progressDialog.show();

                  FirebaseAuth auth = FirebaseAuth.instance;
                  UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
                  if(userCredential.user != null){
                    // ignore: use_build_context_synchronously
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainScreen()),);
                  }
                  else {
                    Fluttertoast.showToast(msg: 'User Not Found');
                  }

                },
                  style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
                    borderRadius:  BorderRadius.circular(25.0),),
                      padding: const EdgeInsets.all(10)
                  ),
                  child: const Text('Login', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black87),)
              ),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Register Here !',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black87),),
                 TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()),);
                    },
                     child: const Text('Register',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.cyan),)
                 ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
