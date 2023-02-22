import 'dart:convert';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;

class LocationService extends GetxController {
  postData() async {
    String username = 'am9uZUAyOTc4';
    String password = 'RklUTkVTU0AjMTIz';
    dynamic data = {
      "pandit_id": "7",
      "booking_id": "843",
    };
    String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    final response = await http.post(
        Uri.https('dev-env.vaikunth.co', '/api/viewdetail'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'authorization': basicAuth
        },
        body: jsonEncode(data));
    if (response.statusCode == 200) {
      var responseJson =
          response.body.isEmpty ? true : jsonDecode(response.body);
      return responseJson;
    }
  }
}
