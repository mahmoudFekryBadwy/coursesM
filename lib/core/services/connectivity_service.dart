import 'dart:io';

class ConnectivityService {
  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty &&
          result[0]
              .rawAddress
              .isNotEmpty; // true if success and there is a response
    } catch (e) {
      return false;
    }
  }
}
