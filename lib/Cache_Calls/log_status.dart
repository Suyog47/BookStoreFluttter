import 'dart:io';
import 'package:path_provider/path_provider.dart';

class GetSetLogStatus {
  var fileName = "logStatus.json";

  Future setLoginStatus(String email) async {
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    file.writeAsStringSync(email, flush: true, mode: FileMode.write);
  }

  Future<dynamic> getLoginStatus() async {
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);

    if(file.existsSync()){
      var data = file.readAsStringSync();
      return data;
    }
    else{
      return false;
    }
  }

  Future<dynamic> deleteLoginStatus() async {
    var dir = await getTemporaryDirectory();
    File file = new File(dir.path + "/" + fileName);
    if(file.existsSync()){
      file.delete();
    }
  }

}