import 'package:ab_project/ui/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {

    final key = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
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
              Center(child: Text('Register', style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),)),
              SizedBox(height: 15,),
              // Center(child: Text('Please Login Here!', style: TextStyle(
              //   color: Colors.white,
              //   fontSize: 20
              //  ))),
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
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Name',
                                hintStyle: TextStyle(color: Colors.grey)
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Name is required.';
                                }
                              },
                            ),
                          ),
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
                              },
                            ),
                          )
                        ],
                      )),
                      SizedBox(height: 40,),
                      TextButton(onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                          LoginScreen()
                        ));
                      }, child: Text('Please Login', style: TextStyle(color: Colors.blue),)),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: OutlinedButton(onPressed: (){
                          if (key.currentState!.validate()) {
                            print(emailController.text);
                          }
                        }, child: Text('Register', style: TextStyle(color: Colors.white),)),
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
