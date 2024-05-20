import 'dart:convert';

import 'package:api_tuturial_1/Model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserModel> userlist = [];
  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userlist.add(UserModel.fromJson(i as Map<String, dynamic>));
      }
      return userlist;
    } else {
      return userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User API'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: userlist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //  Text(postlist[index].title.toString()), OR
                                  Text(' id: ${userlist[index].id}'),
                                  Text('name: ${userlist[index].name}'),
                                  Text('username: ${userlist[index].username}'),
                                  Text('email: ${userlist[index].email}'),
                                  // Text('address: ${userlist[index].address?.city}'),
                                  // Text('suit: ${userlist[index].address?.suite}'),
                                  // Text('street: ${userlist[index].address?.street}'),
                                  // Text('geo: ${userlist[index].address!.geo?.lat}'),
                                  //printing in one line
                                  Text('address: ${userlist[index].address?.city}, '
                                     'suit: ${userlist[index].address?.suite}, '
                                     'street: ${userlist[index].address?.street}, '
                                     'geo: ${userlist[index].address?.geo?.lat}'),

                                  Text('phone: ${userlist[index].phone}'),
                                  Text('website: ${userlist[index].website}'),
                                  Text('companey: ${userlist[index].company}'),
                                ],
                              ),
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
