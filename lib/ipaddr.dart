import 'dart:convert';
import 'package:http/http.dart' as http;

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
