// import 'package:ab_project/auth/api_client.dart';
// import 'package:ab_project/auth/login_status.dart';
// import 'package:ab_project/auth/store.dart';
// import 'package:ab_project/main.dart';
// import 'package:ab_project/models/message.dart';
// import 'package:ab_project/models/user.dart';
// import 'package:ab_project/ui/register_screen.dart';
// import 'package:dio/dio.dart';
import 'package:ab_project/auth/api_client.dart';
import 'package:ab_project/auth/store.dart';
import 'package:ab_project/models/message.dart';
import 'package:ab_project/models/post.dart';
import 'package:ab_project/ui/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  String message = '';
  @override
  Widget build(BuildContext context) {

    final key = GlobalKey<FormState>();
    TextEditingController titleController = TextEditingController();
    TextEditingController desController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('AB NEWS Post')),
      body: Container(
        decoration: BoxDecoration(color: Colors.red),
        width: double.infinity,
        child: Column(children: [
          SizedBox(height: 80,),
          Padding(padding: EdgeInsets.all(20),
            child: Column(children: [
              SizedBox(height: 20,),
              Center(child: Text('Add New Post', style: TextStyle(
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
                              controller: titleController,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Post Title',
                                hintStyle: TextStyle(color: Colors.grey)
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Title is required.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
                              controller: desController,
                              decoration: InputDecoration(
                                hintText: 'Enter Your Post Description',
                                hintStyle: TextStyle(color: Colors.grey)
                              ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Description is required.';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      )),
                      SizedBox(height: 40,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: OutlinedButton(onPressed: () async{
                          if (key.currentState!.validate()) {
                           Post post =  Post(0, titleController.text, desController.text);
                           String api = Provider.of<Store>(context, listen: false).getApi();
                           Message mess = await ApiClient(Dio()).createPost('Bearer ${api}', post);
                           if (mess.status) {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return home();

                            }));
                           }
                          }
                        }, child: Text('Save', style: TextStyle(color: Colors.white),)),
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
