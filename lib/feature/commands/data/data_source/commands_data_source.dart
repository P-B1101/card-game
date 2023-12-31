import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:socket_io/socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

import '../../../../core/utils/extensions.dart';
import '../../../user/domain/entity/user.dart';
import '../../domain/entity/network_device.dart';
import '../../domain/entity/server_message.dart';
import '../model/network_device_model.dart';
import '../model/server_message_model.dart';

abstract class CommandsDataSource {
  Future<void> createServer(User user);

  Future<Stream<ServerMessage>> connectToServer(User user);

  Future<void> closeServer(User user);

  Future<void> disconnectFromServer(User user);

  Future<void> sendMessage({
    required User user,
    required String message,
  });

  Future<Stream<List<NetworkDevice>>> getPlayers();
}

@LazySingleton(as: CommandsDataSource)
class CommandsDataSourceImpl implements CommandsDataSource {
  final Server io;
  final socket_io.Socket socket;
  final List<NetworkDevice> _items = [];
  Socket? _serverSocket;

  CommandsDataSourceImpl({
    required this.io,
    required this.socket,
  });

  static const _serverList = 'server-list';
  static const _serverMessage = 'srv-msg';
  static const _clientMessage = 'clt-msg';

  void _sendClientMessage(String message, [String? event]) =>
      socket.emit(event ?? _serverMessage, utf8.encode(message));

  String _readMessage(List<int> bytes) => utf8.decode(bytes);

  Uint8List get _listMessage => utf8.encode(json.encode(
      _items.map((e) => NetworkDeviceModel.fromEntity(e).toJson).toList()));

  @override
  Future<void> createServer(User user) async {
    final nsp = io.of('/card-game');
    nsp.on('connection', (server) {
      if (server is! Socket) return;
      _serverSocket = server;
      _items
          .addIfNotExist(NetworkDevice(id: user.username, name: user.username));
      server.emit(_serverList, _listMessage);
      server.on(_serverMessage, (data) {
        server.broadcast.emit(_clientMessage, data);
        server.emit(_clientMessage, data);
      });
      server.on(_serverList, (data) => server.broadcast.emit(_serverList, _listMessage));
    });
    await io.listen(1212);
  }

  @override
  Future<void> closeServer(User user) async {
    _items.removeIfExist(user.username);
    _serverSocket?.emit(_serverList, _listMessage);
    _serverSocket = null;
    await io.close();
  }

  @override
  Future<Stream<ServerMessage>> connectToServer(User user) async {
    StreamController<ServerMessage> controller = StreamController();
    socket.on(_clientMessage, (data) {
      if (data is! List) return;
      final body =
          json.decode(_readMessage(data.map((e) => e as int).toList()));
      if (controller.isClosed) return;
      controller.add(ServerMessageModel.fromJson(body));
    });
    final serverMessage = ServerMessageModel.hello(user.username);
    _sendClientMessage(json.encode(serverMessage.toJson));
    return controller.stream;
  }

  @override
  Future<void> disconnectFromServer(User user) async {
    socket.disconnect();
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
  Future<Stream<List<NetworkDevice>>> getPlayers() async {
    StreamController<List<NetworkDevice>> controller = StreamController();
    socket.on(
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
    _sendClientMessage(_serverList, _serverList);
    return controller.stream;
  }
}
