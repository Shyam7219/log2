import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:log2/profilepage.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  static Future<User?> loginUsingEmailPassword({ required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    }on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        print('No user found for that email');
        
      }
    }
    return user;
  }
  @override
  Widget build(BuildContext context) {

    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    
    return   
       Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
    
           const Text('Hey! there', style: TextStyle( 
              color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
              ),
    
             const Text('Login to your App',style: TextStyle(color: Colors.black,fontSize: 40,fontWeight:FontWeight.bold),
              ),

             const Padding(padding: EdgeInsets.only(top: 70)
              ),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail,color: Colors.black,),
                  hintText: 'Email'
                ),
              ),

             const Padding(padding: EdgeInsets.only(top: 20)
              ),

               TextField(
                controller: _passwordController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock,color: Colors.black,),
                  hintText: 'Password'
                ),
              ),

              const Padding(padding: EdgeInsets.only(top: 20)
              ),

             const  Text("forgot password" , style: TextStyle(color: Colors.blue,fontSize: 15),
             ),

             const Padding(padding: EdgeInsets.only(top: 120)
              ),

              Container(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async{
                    User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                    print(user);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => ProfilePage()));
                    }


                  },
                  child:const Text('Login',style: TextStyle(fontSize: 20),)),
              )
          ],
        ),
      );
    
  }
}