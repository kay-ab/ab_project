import 'package:ab_project/auth/api_client.dart';
import 'package:ab_project/auth/store.dart';
import 'package:ab_project/models/post.dart';
import 'package:ab_project/ui/add_post.dart';
import 'package:ab_project/ui/edit_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class home extends StatefulWidget {

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String api = Provider.of<Store>(context).getApi();
    return Scaffold(
      appBar: AppBar(title: Text('Post List Page')),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (contex)=>AddPost()));
      }, child: Icon(Icons.add),),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Post>>(stream: ApiClient(Dio()).getAllPosts('Bearer ${api}'),
          builder: (context, AsyncSnapshot<List<Post>> snapShots) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapShots.data!.length,
              itemBuilder: (context,index) {
                return Container(
                  // padding: EdgeInsets.all(20),
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          height: 80,
                          alignment: Alignment.center,
                          child: Text("${snapShots.data![index].name}", style: TextStyle(color: Colors.red, fontSize: 18),),
                        ),
                        // Description
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "${snapShots.data![index].description}",
                                maxLines : 2,
                              ),
                          ),
                        ),

                        Row(
                          children: [
                            
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditScreen(snapShots.data![index].id)));
                            }, child: Icon(Icons.edit)),
                            TextButton(onPressed: (){

                            }, child: Icon(Icons.delete))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
              );
          },
        ),
      )
    );
    
  }
}
