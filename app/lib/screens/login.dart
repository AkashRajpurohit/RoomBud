import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:roombud/services/auth.dart';


class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  bool isLoading = false;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff5321ad),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Center(
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [  
          
          Text('Welcome To',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0
            )
          ),
          
          Text('ROOMBUD',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5
            )
          ),

          SizedBox(
            height: 70.0,
          ),

          OutlineButton(
            onPressed: () async{

              setState((){
                isLoading = true;
              });

              print('Login button pressed');
              bool loginResult = await AuthService().signInWithGoogle();
              if(loginResult){
                Navigator.pushNamed(context, '/');
              }
              else{
                print('Login Failed');
              }
              setState((){
                isLoading = false;
              });
            },
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(35.0),
            // ),
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            highlightedBorderColor: Colors.white,
            borderSide: BorderSide(color: Colors.white),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.verified_user, color: Colors.white,),
                SizedBox(width: 20.0),
                Text(
                  'SignIn with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white 
                  )
                ),
              ],
            ),
          ),

        ]
      )),
    ));
  }
}