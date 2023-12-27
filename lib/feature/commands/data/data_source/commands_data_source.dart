import 'dart:async';

import 'package:card_game/feature/user/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io/socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class CommandsDataSource {
  Future<void> createServer();

  Future<void> connectToServer(User user);

  Future<void> disconnect();
}

@LazySingleton(as: CommandsDataSource)
class CommandsDataSourceImpl implements CommandsDataSource {
  final Server io;

  const CommandsDataSourceImpl({
    required this.io,
  });

  @override
  Future<void> createServer() async {
    debugPrint('creating...');
    await Future.delayed(const Duration(milliseconds: 500));
    var nsp = io.of('/create-server');
    nsp.on('connection', (client) {
      debugPrint('connection /create-server');
      client.on('msg', (data) {
        debugPrint('data from /create-server => $data');
        client.emit('fromServer', "ok 2");
      });
    });
    io.on('connection', (client) {
      debugPrint('connection default namespace');
      client.on('msg', (data) {
        debugPrint('data from default => $data');
        client.emit('fromServer', "ok");
      });
    });
    await io.listen(3000);
  }

  @override
  Future<void> disconnect() async {
    io.close();
  }

  @override
  Future<void> connectToServer(User user) async {
    IO.Socket socket = IO.io('http://localhost:2000');
    Completer completer = Completer<bool>();
    socket.onConnect((_) {
      debugPrint(_);
      debugPrint('connect');
      socket.emit('msg', 'test');
      if (!completer.isCompleted) completer.complete(true);
    });
    await completer.future.timeout(const Duration(seconds: 10));
  }
}
