
import 'package:ab_project/auth/api_client.dart';
import 'package:ab_project/auth/store.dart';
import 'package:ab_project/main.dart';
import 'package:ab_project/models/message.dart';
import 'package:ab_project/models/post.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  int id;
  EditScreen(this.id);
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String message = '';

  late TextEditingController nameController = TextEditingController();
  late TextEditingController desController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPost();
  }

  getPost() async{
    String api = Provider.of<Store>(context, listen: false).getApi();
    Post post = await ApiClient(Dio()).getPostById('Bearer ${api}',widget.id);
    setState(() {
      nameController = TextEditingController(text: post.name);
      desController = TextEditingController(text: post.description);
    });
  }
  
  @override
  Widget build(BuildContext context) {

    final key = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: Text('Edit Post')),
      body: Container(
        decoration: BoxDecoration(color: Colors.red),
        width: double.infinity,
        child: Column(children: [
          SizedBox(height: 80,),
          Padding(padding: EdgeInsets.all(20),
            child: Column(children: [
              SizedBox(height: 20,),
              Center(child: Text('Edit Post', style: TextStyle(
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
                              controller: nameController,
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
                          Post post = Post(widget.id, nameController.text, desController.text);
                          String api = Provider.of<Store>(context, listen: false).getApi();
                          Message mess = await ApiClient(Dio()).updatePost('Bearer ${api}',post, widget.id);
                          if (mess.status == true) {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyApp()));
                          }
                        }, child: Text('Update', style: TextStyle(color: Colors.white),)),
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
