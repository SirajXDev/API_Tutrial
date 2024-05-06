import 'dart:convert';

import 'package:api_tuturial_1/Model/image_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageApiState();
}

class _ImageApiState extends State<ImageScreen> {
  List<ImageModel> imagelist = [];

  Future<List<ImageModel>> getImageApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        imagelist.add(ImageModel.fromJson(i as Map<String, dynamic>));
      }
      return imagelist;
    } else {
      return imagelist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image API Calling'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueAccent,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getImageApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: imagelist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //  Text(postlist[index].title.toString()), OR
                                  Text('album id: ${imagelist[index].albumId}'),
                                  Text('id: ${imagelist[index].id}'),
                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Text('title: ${imagelist[index].title}'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  //Text('url: ${imagelist[index].url}'), just printing the text
                                  Image.network(
                                    
                                    imagelist[index].url ?? ''),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  //Text('thumbnailUrl: ${imagelist[index].thumbnailUrl}'),just printing text
                                  Image.network(
                                      imagelist[index].thumbnailUrl ?? ''),
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
