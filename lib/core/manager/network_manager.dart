import 'dart:io';

import 'package:card_game/core/error/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'device.dart';

abstract class NetworkManager {
  Future<List<Device>> getLocalDevices([bool useCachedData = true]);
  Future<String> getMyIp();
}

@LazySingleton(as: NetworkManager)
class NetworkManagerImpl implements NetworkManager {
  final List<Device> _items = [];
  NetworkManagerImpl();

  @override
  Future<String> getMyIp() async {
    final items = await NetworkInterface.list();
    final addresses = <String>[];
    for (int i = 0; i < items.length; i++) {
      for (var element in items[i].addresses) {
        addresses.add(element.address);
      }
    }
    if (addresses.isEmpty) {
      throw const ServerException(message: 'Fail to get my IP');
    }
    return addresses.first;
  }

  @override
  Future<List<Device>> getLocalDevices([bool useCachedData = true]) async {
    if (_items.isNotEmpty && useCachedData) return _items;
    try {
      final mIP = await getMyIp();
      final String subnet = mIP.substring(0, mIP.lastIndexOf('.'));
      final result = <Device>[];
      for (int i = 2; i < 256; i++) {
        const port = 1212;
        final ip = '$subnet.$i';
        try {
          final socket = await Socket.connect(ip, port,
              timeout: const Duration(milliseconds: 15));
          final address =
              await InternetAddress(socket.address.address).reverse();
          result.add(Device(name: address.host, ip: ip));
          socket.destroy();
        } catch (error) {
          continue;
        }
      }
      _items.clear();
      _items.addAll(result);
      return result;
    } catch (error) {
      debugPrint(error.toString());
      return [];
    }
  }
}
