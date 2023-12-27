import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';

abstract class DataBaseDataSource {
  Future<void> saveAuth(String data);

  String getAuth();

  String? tryGetAuth();

  Future<void> removeAllData();
}

@LazySingleton(as: DataBaseDataSource)
class DataBaseDataSourceImpl implements DataBaseDataSource {
  final SharedPreferences sharedPreferences;

  const DataBaseDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<void> saveAuth(String data) =>
      sharedPreferences.setString(_authKey, data);

  @override
  String getAuth() {
    final result = sharedPreferences.getString(_authKey);
    if (result == null) throw const UnAuthorizeException();
    return result;
  }

  @override
  Future<void> removeAllData() => sharedPreferences.clear();

  @override
  String? tryGetAuth() => sharedPreferences.getString(_authKey);
}

const _authKey = 'PhOWWARE';
