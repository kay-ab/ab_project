import 'package:ab_project/auth/api_client.dart';
import 'package:ab_project/auth/login_status.dart';
import 'package:ab_project/auth/store.dart';
import 'package:ab_project/main.dart';
import 'package:ab_project/models/message.dart';
import 'package:ab_project/models/user.dart';
import 'package:ab_project/ui/register_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String message = '';
  @override
  Widget build(BuildContext context) {

    final key = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('AB NEWS')),
      body: Container(
        decoration: BoxDecoration(color: Colors.red),
        width: double.infinity,
        child: Column(children: [
          SizedBox(height: 80,),
          Padding(padding: EdgeInsets.all(20),
            child: Column(children: [
              SizedBox(height: 20,),
              Center(child: Text('Login', style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),)),
              SizedBox(height: 15,),
              Center(child: Text('${message}', style: TextStyle(
                color: Colors.white,
                fontSize: 20
               ))),
            ]),
          ),
          Expanded(child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(padding: EdgeInsets.all(30),
              child:SingleChildScrollView(
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(children: [
                      Form(
                        key: key,
                        child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Email',
                                hintStyle: TextStyle(color: Colors.grey)
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Email is required.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Password',
                                hintStyle: TextStyle(color: Colors.grey)
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Password is required.';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      )),
                      SizedBox(height: 40,),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (contex){
                          return RegisterScreen();
                        }));
                      }, child: Text('Create New Register', style: TextStyle(color: Colors.blue),)),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: OutlinedButton(onPressed: () async{
                          if (key.currentState!.validate()) {
                            User user = User('admin', emailController.text, passwordController.text);
                            Message mess = await ApiClient(Dio()).login(user);
                            if (mess.status) {
                              Provider.of<Store>(context, listen: false).setApi(mess.api);
                              Provider.of<LoginStatus>(context, listen: false).setStatus(true);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));
                            } else {
                              setState(() {
                                this.message = mess.message;
                              });
                            }
                          }
                        }, child: Text('Login', style: TextStyle(color: Colors.white),)),
                      )
                    ]),
                  )
                ]),
              ),
            ),))
        ]),
      ),
    );
  }
}
