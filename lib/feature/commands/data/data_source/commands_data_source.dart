import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:card_game/feature/user/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:socket_io/socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

import '../../../../core/manager/network_manager.dart';
import '../../../../core/utils/extensions.dart';
import '../../../user/domain/entity/user.dart';
import '../../domain/entity/network_device.dart';
import '../../domain/entity/server_message.dart';
import '../model/network_device_model.dart';
import '../model/server_message_model.dart';

abstract class CommandsDataSource {
  Future<void> createServer(User user);

  Future<Stream<ServerMessage>> connectToServer(
    User user,
    NetworkDevice? server,
  );

  Future<void> closeServer(User user);

  Future<void> disconnectFromServer(User user);

  Future<void> sendMessage({
    required User user,
    required String message,
  });

  Future<List<NetworkDevice>> getServers(bool useCachedData);

  Future<Stream<List<NetworkDevice>>> getPlayers();
}

@LazySingleton(as: CommandsDataSource)
class CommandsDataSourceImpl implements CommandsDataSource {
  final Server server;
  final NetworkManager networkManager;
  final List<NetworkDevice> _items = [];
  socket_io.Socket? clientSocket;
  // Socket? _serverSocket;

  CommandsDataSourceImpl({
    required this.server,
    required this.networkManager,
    // required this.socket,
  });

  static const _serverList = 'server-list';
  static const _serverMessage = 'srv-msg';
  static const _clientMessage = 'clt-msg';
  static const _leaveLobby = 'lve-lby';
  static const _joinLobby = 'jn-lby';

  void _sendClientMessage(String message, [String? event]) =>
      clientSocket?.emit(event ?? _serverMessage, utf8.encode(message));

  String _readMessage(List<int> bytes) => utf8.decode(bytes);

  Uint8List get _listMessage => utf8.encode(json.encode(
      _items.map((e) => NetworkDeviceModel.fromEntity(e).toJson).toList()));

  @override
  Future<void> createServer(User user) async {
    final nsp = server.of('/card-game');
    nsp.on('connection', (server) {
      if (server is! Socket) return;
      // _serverSocket = server;
      // _items.addIfNotExist(NetworkDevice(
      //   id: user.ip,
      //   name: user.username,
      //   ip: user.ip,
      // ));
      server.emit(_serverList, _listMessage);
      server.on(_serverMessage, (data) {
        server.broadcast.emit(_clientMessage, data);
        server.emit(_clientMessage, data);
      });
      server.on(_serverList, (data) {
        server.broadcast.emit(_serverList, _listMessage);
        server.emit(_serverList, _listMessage);
      });
      server.on(_leaveLobby, (data) {
        if (data is! List) return;
        final body = _readMessage(data.map((e) => e as int).toList());
        final user = UserModel.fromJson(json.decode(body));
        _items.removeIfExist(user.ip);
        server.broadcast.emit(_serverList, _listMessage);
        server.emit(_serverList, _listMessage);
      });
      server.on(_joinLobby, (data) {
        if (data is! List) return;
        final body = _readMessage(data.map((e) => e as int).toList());
        _items.addIfNotExist(NetworkDeviceModel.fromJson(json.decode(body)));
        server.broadcast.emit(_serverList, _listMessage);
        server.emit(_serverList, _listMessage);
      });
    });
    await server.listen(1212);
  }

  @override
  Future<void> closeServer(User user) async {
    // _serverSocket = null;
    await server.close();
  }

  @override
  Future<Stream<ServerMessage>> connectToServer(
    User user,
    NetworkDevice? server,
  ) async {
    StreamController<ServerMessage> controller = StreamController();
    final host = server?.ip ?? 'localhost';
    final uri = 'http://$host:1212/card-game';
    debugPrint('try to connect to $uri ...');
    clientSocket = socket_io.io(
      uri,
      socket_io.OptionBuilder().setTransports(['websocket']).build(),
    );
    clientSocket?.on(_clientMessage, (data) {
      if (data is! List) return;
      final body =
          json.decode(_readMessage(data.map((e) => e as int).toList()));
      if (controller.isClosed) return;
      controller.add(ServerMessageModel.fromJson(body));
    });
    final device =
        NetworkDeviceModel(id: user.ip, name: user.username, ip: user.ip);
    _sendClientMessage(json.encode(device.toJson), _joinLobby);
    final serverMessage = ServerMessageModel.hello(user.username);
    _sendClientMessage(json.encode(serverMessage.toJson));
    return controller.stream;
  }

  @override
  Future<void> disconnectFromServer(User user) async {
    _sendClientMessage(
        json.encode(UserModel.fromEntity(user).toJson), _leaveLobby);
    clientSocket?.disconnect();
    clientSocket = null;
  }

  @override
  Future<void> sendMessage({
    required User user,
    required String message,
  }) async {
    final serverMessage = ServerMessageModel.message(user.username, message);
    _sendClientMessage(json.encode(serverMessage.toJson));
  }

  @override
  Future<List<NetworkDevice>> getServers(bool useCachedData) async {
    final items = await networkManager.getLocalDevices(useCachedData);
    final result = <NetworkDevice>[];
    for (int i = 0; i < items.length; i++) {
      result.add(
          NetworkDevice(id: items[i].ip, ip: items[i].ip, name: items[i].name));
    }
    return result;
  }

  @override
  Future<Stream<List<NetworkDevice>>> getPlayers() async {
    StreamController<List<NetworkDevice>> controller = StreamController();
    clientSocket?.on(
      _serverList,
      (data) {
        if (data is! List) return;
        final body =
            json.decode(_readMessage(data.map((e) => e as int).toList()));
        if (body is! List) return;
        if (controller.isClosed) return;
        controller
            .add(body.map((e) => NetworkDeviceModel.fromJson(e)).toList());
      },
    );
    Future.delayed(const Duration(milliseconds: 500)).then((value) {
      _sendClientMessage(_serverList, _serverList);
    });
    return controller.stream;
  }
}
