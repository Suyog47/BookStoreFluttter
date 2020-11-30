import 'package:http/http.dart' as http;
import 'dart:convert';

class GetLocation{

  Future<String> getData(String pincode) async {
    var url = "http://www.postalpincode.in/api/pincode/" + pincode;
    var response = await http.get(url);
    var res = jsonDecode(response.body);

    if(res["PostOffice"] != null) {
      var dataObj = res["PostOffice"][0];
      return (dataObj["District"]+", "+dataObj["State"]);
    }
    return null;
  }
}