import 'dart:convert';

import 'package:api_tuturial_1/Model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postlist = [];

  Future<List<PostModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        postlist.add(PostModel.fromJson(i as Map<String, dynamic>));
      }
      return postlist;
    } else {
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Course'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const  Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: postlist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                const Text('Title',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              //  Text(postlist[index].title.toString()), OR
                                Text('Title: ${postlist[index].title}'),
                                Text('id: ${postlist[index].id}'),
                               const SizedBox(height: 5,),
                                 const Text('Description',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                Text(postlist[index].body.toString()),
                                
                              ],),
                            ),
                          );
                        });
                  }
                }),
          ),
       
        ],
      ),
    );
  }
}
