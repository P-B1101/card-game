import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

abstract class DataBaseDataSource {
  Future<void> saveUsername(String username);

  String getUsername();

  String? tryGetUsername();

  Future<void> removeAllData();
}

@LazySingleton(as: DataBaseDataSource)
class DataBaseDataSourceImpl implements DataBaseDataSource {
  final SharedPreferences sharedPreferences;

  const DataBaseDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<void> saveUsername(String data) =>
      sharedPreferences.setString(_username, data);

  @override
  String getUsername() {
    final result = sharedPreferences.getString(_username);
    if (result == null) throw const UnAuthorizeException();
    return result;
  }

  @override
  Future<void> removeAllData() => sharedPreferences.clear();

  @override
  String? tryGetUsername() => sharedPreferences.getString(_username);
}

const _username = 'PhOWWARE';
