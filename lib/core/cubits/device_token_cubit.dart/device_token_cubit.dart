import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_device_id/flutter_device_id.dart';

class DeviceTokenCubit extends Cubit<String?> {
  DeviceTokenCubit() : super(null);

  Future<void> fetchDeviceToken() async {
    final flutterDeviceIdPlugin = FlutterDeviceId();
    String? deviceInfo;
    deviceInfo = await flutterDeviceIdPlugin.getDeviceId() ?? '';

    emit(deviceInfo);
  }
}

// class DeviceTokenCubit extends Cubit<String?> {
//   DeviceTokenCubit() : super(null);

//   Future<void> fetchDeviceToken() async {
//       DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
// AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

//     emit(androidInfo.id);
//   }
// }
