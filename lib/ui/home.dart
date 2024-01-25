import 'package:ab_project/auth/api_client.dart';
import 'package:ab_project/auth/store.dart';
import 'package:ab_project/models/post.dart';
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
    return SingleChildScrollView(
      child: StreamBuilder<List<Post>>(stream: ApiClient(Dio()).getAllPosts('Bearer ${api}'),
        builder: (context, AsyncSnapshot<List<Post>> snapShots) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapShots.data!.length,
            itemBuilder: (context,index) {
              return Card(
                child: Row(
                  children: [
                    Container(
                      child: Text("${snapShots.data![index].name}"),
                    )
                  ],
                ),
              );
            }
            );
        },
      ),
    );
  }
}
