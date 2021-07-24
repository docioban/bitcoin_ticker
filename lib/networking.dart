import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  Networking({this.url});

  final String url;

  Future getData() async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return (jsonDecode(response.body));
    } else {
      print(Error);
      return (null);
    }
  }
}
