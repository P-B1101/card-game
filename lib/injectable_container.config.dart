// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:card_game/feature/commands/data/data_source/commands_data_source.dart'
    as _i6;
import 'package:card_game/feature/commands/data/repository/commands_repository_impl.dart'
    as _i12;
import 'package:card_game/feature/commands/domain/repository/commands_repository.dart'
    as _i11;
import 'package:card_game/feature/commands/domain/use_case/close_server.dart'
    as _i17;
import 'package:card_game/feature/commands/domain/use_case/connect_to_server.dart'
    as _i13;
import 'package:card_game/feature/commands/domain/use_case/create_server.dart'
    as _i14;
import 'package:card_game/feature/commands/domain/use_case/disconnect_from_server.dart'
    as _i15;
import 'package:card_game/feature/commands/domain/use_case/send_message.dart'
    as _i16;
import 'package:card_game/feature/commands/presentation/bloc/connect_to_server_bloc.dart'
    as _i18;
import 'package:card_game/feature/commands/presentation/bloc/create_server_bloc.dart'
    as _i19;
import 'package:card_game/feature/database/data/data_source/database_data_source.dart'
    as _i7;
import 'package:card_game/feature/database/data/repository/database_repository_impl.dart'
    as _i9;
import 'package:card_game/feature/database/domain/repository/database_repository.dart'
    as _i8;
import 'package:card_game/feature/repository_manager/repository_manager.dart'
    as _i10;
import 'package:card_game/injectable_container.dart' as _i20;
import 'package:fluttertoast/fluttertoast.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;
import 'package:socket_io/socket_io.dart' as _i4;

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
    final registerServer = _$RegisterServer();
    final registerSharedPref = _$RegisterSharedPref();
    gh.lazySingleton<_i3.FToast>(() => registerFToast.tosat);
    gh.lazySingleton<_i4.Server>(() => registerServer.server);
    await gh.lazySingletonAsync<_i5.SharedPreferences>(
      () => registerSharedPref.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i6.CommandsDataSource>(
        () => _i6.CommandsDataSourceImpl(io: gh<_i4.Server>()));
    gh.lazySingleton<_i7.DataBaseDataSource>(() => _i7.DataBaseDataSourceImpl(
        sharedPreferences: gh<_i5.SharedPreferences>()));
    gh.lazySingleton<_i8.DatabaseRepository>(() =>
        _i9.DatabaseRepositoryImpl(dataSource: gh<_i7.DataBaseDataSource>()));
    gh.lazySingleton<_i10.RepositoryHelper>(() => _i10.RepositoryHelperImpl(
        databaseDataSource: gh<_i7.DataBaseDataSource>()));
    gh.lazySingleton<_i11.CommandsRepository>(() => _i12.CommandsRepositoryImpl(
          dataSource: gh<_i6.CommandsDataSource>(),
          repositoryHelper: gh<_i10.RepositoryHelper>(),
        ));
    gh.lazySingleton<_i13.ConnectToServer>(
        () => _i13.ConnectToServer(repository: gh<_i11.CommandsRepository>()));
    gh.lazySingleton<_i14.CreateServer>(
        () => _i14.CreateServer(repository: gh<_i11.CommandsRepository>()));
    gh.lazySingleton<_i15.DisconnectServer>(
        () => _i15.DisconnectServer(repository: gh<_i11.CommandsRepository>()));
    gh.lazySingleton<_i16.SendMessage>(
        () => _i16.SendMessage(repository: gh<_i11.CommandsRepository>()));
    gh.lazySingleton<_i17.CloseServer>(
        () => _i17.CloseServer(repository: gh<_i11.CommandsRepository>()));
    gh.factory<_i18.ConnectToServerBloc>(() => _i18.ConnectToServerBloc(
          gh<_i13.ConnectToServer>(),
          gh<_i17.CloseServer>(),
          gh<_i16.SendMessage>(),
        ));
    gh.factory<_i19.CreateServerBloc>(() => _i19.CreateServerBloc(
          gh<_i14.CreateServer>(),
          gh<_i17.CloseServer>(),
        ));
    return this;
  }
}

class _$RegisterFToast extends _i20.RegisterFToast {}

class _$RegisterServer extends _i20.RegisterServer {}

class _$RegisterSharedPref extends _i20.RegisterSharedPref {}
