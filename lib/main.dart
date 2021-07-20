import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:animated_background/animated_background.dart';


Future<ShowPublicIP> fetchPublicIP() async {
  final response =
  await http.get(Uri.parse('https://whatismyip-api.herokuapp.com/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ShowPublicIP.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class ShowPublicIP {

  final String publicIP;

  ShowPublicIP({
    required this.publicIP,
  });

  factory ShowPublicIP.fromJson(Map<String, dynamic> json) {
    return ShowPublicIP(
      publicIP: json['public_ip'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<ShowPublicIP> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchPublicIP();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What is my IP?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<ShowPublicIP>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.publicIP);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}