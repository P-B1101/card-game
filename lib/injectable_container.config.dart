// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:card_game/feature/database/data/data_source/database_data_source.dart'
    as _i5;
import 'package:card_game/feature/database/data/repository/database_repository_impl.dart'
    as _i7;
import 'package:card_game/feature/database/domain/repository/database_repository.dart'
    as _i6;
import 'package:card_game/feature/repository_manager/repository_manager.dart'
    as _i8;
import 'package:card_game/injectable_container.dart' as _i9;
import 'package:fluttertoast/fluttertoast.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerFToast = _$RegisterFToast();
    final registerSharedPref = _$RegisterSharedPref();
    gh.lazySingleton<_i3.FToast>(() => registerFToast.tosat);
    await gh.lazySingletonAsync<_i4.SharedPreferences>(
      () => registerSharedPref.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i5.DataBaseDataSource>(() => _i5.DataBaseDataSourceImpl(
        sharedPreferences: gh<_i4.SharedPreferences>()));
    gh.lazySingleton<_i6.DatabaseRepository>(() =>
        _i7.DatabaseRepositoryImpl(dataSource: gh<_i5.DataBaseDataSource>()));
    gh.lazySingleton<_i8.RepositoryHelper>(() => _i8.RepositoryHelperImpl(
        databaseDataSource: gh<_i5.DataBaseDataSource>()));
    return this;
  }
}

class _$RegisterFToast extends _i9.RegisterFToast {}

class _$RegisterSharedPref extends _i9.RegisterSharedPref {}
