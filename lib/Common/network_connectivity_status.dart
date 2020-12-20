import 'package:connectivity/connectivity.dart';

class NetworkCheck{

    Future<int> checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none){
      return 0;
    }
    else{
      return 1;
    }

  }
}