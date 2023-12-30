import 'dart:async';
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:socket_io/socket_io.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

import '../../../user/domain/entity/user.dart';
import '../../domain/entity/server_message.dart';
import '../model/server_message_model.dart';

abstract class CommandsDataSource {
  Future<Stream<ServerMessage>> createServer();

  Future<void> connectToServer(User user);

  Future<void> closeServer();

  Future<void> disconnectFromServer(User user);

  Future<void> sendMessage({
    required User user,
    required String message,
  });
}

@LazySingleton(as: CommandsDataSource)
class CommandsDataSourceImpl implements CommandsDataSource {
  final Server io;
  socket_io.Socket? socket;
  CommandsDataSourceImpl({
    required this.io,
  });

  @override
  Future<Stream<ServerMessage>> createServer() async {
    StreamController<ServerMessage> controller = StreamController();
    var nsp = io.of('/create-server');
    nsp.on('connection', (client) {
      // if (client is! Socket) return;
      // client.once('msg', (data) {
      //   final header = client.request.headers;
      //   final user = header.value('user');
      //   if (user != null) controller.add(ServerMessage.hello(user));
      // });
      client.on('msg', (data) {
        // if (data is! String) return;
        if (data is! List) return;
        final body =
            json.decode(_readMessage(data.map((e) => e as int).toList()));
        if (controller.isClosed) return;
        controller.add(ServerMessageModel.fromJson(body));
      });
    });
    // nsp.on('disconnect', (data) {});
    await io.listen(1212);
    return controller.stream;
  }

  @override
  Future<void> closeServer() async {
    io.close();
  }

  @override
  Future<void> connectToServer(User user) async {
    socket = socket_io.io(
      'http://localhost:1212/create-server',
      socket_io.OptionBuilder().setTransports(['websocket']).setExtraHeaders({
        'user': user.username,
      }).build(),
    );
    Completer completer = Completer<bool>();
    socket?.onConnect((_) {
      final serverMessage = ServerMessageModel.hello(user.username);
      _sendMessage(json.encode(serverMessage.toJson));
      if (!completer.isCompleted) completer.complete(true);
    });
    await completer.future.timeout(const Duration(seconds: 30));
  }

  @override
  Future<void> disconnectFromServer(User user) async {
    if (socket == null) return;
    socket?.disconnect();
  }

  @override
  Future<void> sendMessage({
    required User user,
    required String message,
  }) async {
    final serverMessage = ServerMessageModel.message(user.username, message);
    _sendMessage(json.encode(serverMessage.toJson));
  }

  void _sendMessage(String message) =>
      socket?.emit('msg', utf8.encode(message));

  String _readMessage(List<int> bytes) => utf8.decode(bytes);
}
