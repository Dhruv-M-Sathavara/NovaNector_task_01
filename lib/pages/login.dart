import 'package:flutter/material.dart';
import 'package:to_do/Authfunction/authFunction.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final _formkey = GlobalKey<FormState>();

  bool islogin = false;
  String emailAddress = '';
  String password = '';
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
      body: SingleChildScrollView(scrollDirection:Axis.vertical, child:  Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(child: 
            Image(image: NetworkImage('https://img.freepik.com/premium-vector/schedule-check-list-with-pencil-illustration_53562-8305.jpg?semt=ais_hybrid'),height: 300),
            ),
            Form(key:_formkey, child: Container(
              child: Column(children: [ !islogin ?
                TextFormField(
                  key: ValueKey('username'),
              style: TextStyle(fontSize:18,color:Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.verified_user_outlined),
                hintText: 'Username',contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
                ),
              ),
              validator:(value){
                if(value.toString().length<3){
                  return 'too Sort Write Greter than 5 letter';
                }
                else{
                  return null;
                }
              },
              onSaved: (value){
                setState(() {
                  username = value!;
                });
              },
            ):Container(),
            SizedBox(height: 15),
            TextFormField(
              key: ValueKey('email'),
              style: TextStyle(fontSize:18,color:Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail),
                hintText: 'Email',contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
                )
              ),
              validator: (value) {
                if(value.toString().isEmpty){
                  return 'Enter Email';
                }
                else{
                  return null;
                }
              },
              onSaved: (value){
                setState(() {
                  emailAddress = value!;
                });
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              key: ValueKey('password'),  
              style: TextStyle(fontSize:18,color:Colors.black),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.password),
                hintText: 'Comfirm Password',contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
                )
              ),
              validator: (value) {
                if(value.toString().length<6){
                  return 'Password is short create 6 or mmore letter';
                }
                return null;
              },
              onSaved: (value){
                setState(() {
                  password = value!;
                });
              },
            ),
            SizedBox(height: 15),
            ElevatedButton(onPressed: (){
              if(_formkey.currentState!.validate()){
                _formkey.currentState!.save();
                signup(emailAddress, password);
              }
            }, child: islogin ? Text('Submit') :
            Text('Signup')),
            TextButton(onPressed: (){
              setState(() {
                islogin = !islogin;
              });
            }, child: islogin ? Text('Dont have account') : Text('Already Signed In ? Login')),
              ],),
            ))
            
          ],
        ),
      ),));
    
  }
}