import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../../commands/data/model/server_message_model.dart';
import '../../../commands/domain/entity/server_message.dart';

abstract class SembastDataSource {
  Future<void> addMessage(ServerMessage message, String serverIp);
  Future<List<ServerMessage>> getMessages(String serverIp);
}

@LazySingleton(as: SembastDataSource)
class SembastDataSourceImpl implements SembastDataSource {
  Database? _db;
  final factory = databaseFactoryIo;
  static const dbPath = 'xIlHpACX2M0WtpfJOs8ZV1OQPnsUJyLW.db';
  final StoreRef store;

  SembastDataSourceImpl({
    required this.store,
  });

  Future<void> _initializeDb() async {
    if (_db != null) return;
    _db = await factory.openDatabase(dbPath);
  }

  @override
  Future<void> addMessage(
    ServerMessage message,
    String serverIp,
  ) async {
    await _initializeDb();
    final items = await getMessages(serverIp);
    items.add(message);
    await store.record(serverIp).put(
          _db!,
          items.map((e) => ServerMessageModel.fromEntity(e).toJson).toList(),
        );
  }

  @override
  Future<List<ServerMessage>> getMessages(String serverIp) async {
    await _initializeDb();
    final value = await store.record(serverIp).get(_db!);
    if (value is! List) return [];
    return value.map((e) => ServerMessageModel.fromJson(e)).toList();
  }
}
