import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:network_info_plus/network_info_plus.dart';

import 'device.dart';

abstract class NetworkManager {
  Future<List<Device>> getLocalDevices();
}

@LazySingleton(as: NetworkManager)
class NetworkManagerImpl implements NetworkManager {
  final NetworkInfo info;

  const NetworkManagerImpl({
    required this.info,
  });

  @override
  Future<List<Device>> getLocalDevices() async {
    try {
      final items = await NetworkInterface.list();
      final addresses = <String>[];
      for (int i = 0; i < items.length; i++) {
        for (var element in items[i].addresses) {
          addresses.add(element.address);
        }
      }
      final mIP = addresses.firstOrNull;
      debugPrint(mIP);
      if (mIP == null) return [];
      final String subnet = mIP.substring(0, mIP.lastIndexOf('.'));
      const port = 22;
      final result = <Device>[];
      for (var i = 0; i < 256; i++) {
        try {
          final ip = '$subnet.$i';
          final socket = await Socket.connect(ip, port,
              timeout: const Duration(milliseconds: 50));
          final address =
              await InternetAddress(socket.address.address).reverse();
          result.add(Device(name: address.address, ip: ip));
          socket.destroy();
        } catch (error) {
          debugPrint(error.toString());
        }
      }
      return result;
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }
}
