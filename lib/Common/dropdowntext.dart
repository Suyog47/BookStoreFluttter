import 'package:http/http.dart' as http;
import 'dart:convert';

class DropDownFiles{

  final List<String> boards = ["SSC", "CBSC", "ICSC"];
  final List<String> standards = ["1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th"];
  final List<String> subjects = ["English", "Hindi", "Marathi", "Maths", "Science", "Geography", "History - Civics"];

}

class GetLocation{

  Future<String> getData(String pincode) async {
    var url = "http://www.postalpincode.in/api/pincode/" + pincode;
    var response = await http.get(url);
    var res = jsonDecode(response.body);
    var dataObj = res["PostOffice"][0];

    return(dataObj["District"]+", "+dataObj["State"]);
  }
}