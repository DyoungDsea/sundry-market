import 'package:connectivity_plus/connectivity_plus.dart';

class CheckNetwork {
  static Future<bool> checkConnectivity() async {
    var connectivity = await Connectivity().checkConnectivity();

    if (connectivity == ConnectivityResult.none) {
      return true;
    }

    return false;
  }
}
