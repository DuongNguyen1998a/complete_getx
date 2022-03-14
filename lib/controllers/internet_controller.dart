import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  var connectionType = 0.obs;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getConnectionType();
    streamSubscription = connectivity.onConnectivityChanged.listen((_) {
      getConnectionType();
    });
  }

  @override
  dispose() {
    super.dispose();
    streamSubscription.cancel();
  }

  Future<int> getConnectionType() async {
    ConnectivityResult connectivityResult;
    try {
      connectivityResult = await connectivity.checkConnectivity();

      if (connectivityResult == ConnectivityResult.wifi) {
        connectionType.value = 1;
        return connectionType.value;
      } else if (connectivityResult == ConnectivityResult.mobile) {
        connectionType.value = 2;
        return connectionType.value;
      } else if (connectivityResult == ConnectivityResult.none) {
        connectionType.value = 0;
        return connectionType.value;
      }
      return 0;
    } catch (e) {
      rethrow;
    }
  }
}
