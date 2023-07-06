import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.cyan.shade100,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SafeArea(child:
            Center(child:
            Text('Registration',style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color: Colors.cyan),))),
            const SizedBox(height: 15),

            TextField(
              controller: fullNameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter Full Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
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

            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Confirm Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            const SizedBox(height: 15),

            ElevatedButton(onPressed: () async  {
              var fullName = fullNameController.text.trim();
              var email = emailController.text.trim();
              var password = passwordController.text.trim();
              var confirmPass = confirmPasswordController.text.trim();

              if(fullName.isEmpty || email.isEmpty || password.isEmpty || confirmPass.isEmpty  ){
                Fluttertoast.showToast(msg: 'Please Fill All The Fields');
              }

              if(confirmPass != password){
                Fluttertoast.showToast(msg: 'Password Do Not Matched');
              }

              ProgressDialog progressDialog = ProgressDialog(context,
                  title: const Text('Registering'),
                  message: const Text('Please Wait'));

              progressDialog.show();

              try{
                FirebaseAuth auth = FirebaseAuth.instance;
                UserCredential usercredential = await  auth.createUserWithEmailAndPassword(email: email, password: password);

                if(usercredential.user != null){

                  DatabaseReference userRef = FirebaseDatabase.instance.reference().child('Users');
                  String uid = usercredential.user!.uid;
                  await userRef.child(uid).set({
                    'FullName' : fullName,
                    'Email' : email,
                    'Uid' : uid,

                  });

                  Fluttertoast.showToast(msg: 'Registered Successfully');
                  Navigator.of(context).pop();
                }

                else{
                  Fluttertoast.showToast(msg: 'Registration Failed');
                }
                progressDialog.dismiss();
              }

              on FirebaseAuthException catch(e){
                progressDialog.dismiss();
                if(e.code == 'email-already-in-use')
                  {
                    Fluttertoast.showToast(msg: 'Email Already Exist');
                  }

                if(e.code == 'weak-password')
                {
                  progressDialog.dismiss();
                  Fluttertoast.showToast(msg: 'Password is Weak');
                }

              }

            },

            style: ElevatedButton.styleFrom(shape:  RoundedRectangleBorder(
            borderRadius:  BorderRadius.circular(25.0),),
            padding: const EdgeInsets.all(10)
            ),
            child: const Text('Register', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black87),)),

          ],
        ),
      ),
    );
  }
}
