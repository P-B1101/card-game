// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:card_game/core/manager/network_manager.dart' as _i4;
import 'package:card_game/feature/commands/data/data_source/commands_data_source.dart'
    as _i16;
import 'package:card_game/feature/commands/data/repository/commands_repository_impl.dart'
    as _i18;
import 'package:card_game/feature/commands/domain/repository/commands_repository.dart'
    as _i17;
import 'package:card_game/feature/commands/domain/use_case/close_server.dart'
    as _i29;
import 'package:card_game/feature/commands/domain/use_case/connect_to_server.dart'
    as _i19;
import 'package:card_game/feature/commands/domain/use_case/create_server.dart'
    as _i20;
import 'package:card_game/feature/commands/domain/use_case/disconnect_from_server.dart'
    as _i21;
import 'package:card_game/feature/commands/domain/use_case/get_players.dart'
    as _i22;
import 'package:card_game/feature/commands/domain/use_case/get_servers.dart'
    as _i23;
import 'package:card_game/feature/commands/domain/use_case/listen_for_server_connection.dart'
    as _i24;
import 'package:card_game/feature/commands/domain/use_case/send_message.dart'
    as _i27;
import 'package:card_game/feature/commands/domain/use_case/set_ready.dart'
    as _i28;
import 'package:card_game/feature/commands/presentation/bloc/connect_to_server_bloc.dart'
    as _i30;
import 'package:card_game/feature/commands/presentation/bloc/create_server_bloc.dart'
    as _i31;
import 'package:card_game/feature/commands/presentation/bloc/network_device_bloc.dart'
    as _i25;
import 'package:card_game/feature/commands/presentation/bloc/players_bloc.dart'
    as _i26;
import 'package:card_game/feature/database/data/data_source/database_data_source.dart'
    as _i8;
import 'package:card_game/feature/database/data/data_source/sembast_data_source.dart'
    as _i14;
import 'package:card_game/feature/database/data/repository/database_repository_impl.dart'
    as _i10;
import 'package:card_game/feature/database/domain/repository/database_repository.dart'
    as _i9;
import 'package:card_game/feature/database/domain/use_case/get_username.dart'
    as _i11;
import 'package:card_game/feature/database/domain/use_case/save_username.dart'
    as _i13;
import 'package:card_game/feature/database/presentation/cubit/username_cubit.dart'
    as _i15;
import 'package:card_game/feature/repository_manager/repository_manager.dart'
    as _i12;
import 'package:card_game/injectable_container.dart' as _i32;
import 'package:fluttertoast/fluttertoast.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i7;
import 'package:shared_preferences/shared_preferences.dart' as _i6;
import 'package:socket_io/socket_io.dart' as _i5;

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
    final registerStoreRef = _$RegisterStoreRef();
    gh.lazySingleton<_i3.FToast>(() => registerFToast.tosat);
    gh.lazySingleton<_i4.NetworkManager>(() => _i4.NetworkManagerImpl());
    gh.lazySingleton<_i5.Server>(() => registerServer.server);
    await gh.lazySingletonAsync<_i6.SharedPreferences>(
      () => registerSharedPref.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i7.StoreRef<Object?, Object?>>(
        () => registerStoreRef.store);
    gh.lazySingleton<_i8.DataBaseDataSource>(() => _i8.DataBaseDataSourceImpl(
        sharedPreferences: gh<_i6.SharedPreferences>()));
    gh.lazySingleton<_i9.DatabaseRepository>(() => _i10.DatabaseRepositoryImpl(
          dataSource: gh<_i8.DataBaseDataSource>(),
          networkManager: gh<_i4.NetworkManager>(),
        ));
    gh.lazySingleton<_i11.GetUsername>(
        () => _i11.GetUsername(repository: gh<_i9.DatabaseRepository>()));
    gh.lazySingleton<_i12.RepositoryHelper>(() => _i12.RepositoryHelperImpl(
        databaseDataSource: gh<_i8.DataBaseDataSource>()));
    gh.lazySingleton<_i13.SaveUsername>(
        () => _i13.SaveUsername(repository: gh<_i9.DatabaseRepository>()));
    gh.lazySingleton<_i14.SembastDataSource>(() => _i14.SembastDataSourceImpl(
        store: gh<_i7.StoreRef<Object?, Object?>>()));
    gh.factory<_i15.UsernameCubit>(() => _i15.UsernameCubit(
          gh<_i13.SaveUsername>(),
          gh<_i4.NetworkManager>(),
          gh<_i11.GetUsername>(),
        ));
    gh.lazySingleton<_i16.CommandsDataSource>(() => _i16.CommandsDataSourceImpl(
          server: gh<_i5.Server>(),
          networkManager: gh<_i4.NetworkManager>(),
          sembastDataSource: gh<_i14.SembastDataSource>(),
        ));
    gh.lazySingleton<_i17.CommandsRepository>(() => _i18.CommandsRepositoryImpl(
          dataSource: gh<_i16.CommandsDataSource>(),
          repositoryHelper: gh<_i12.RepositoryHelper>(),
          networkManager: gh<_i4.NetworkManager>(),
        ));
    gh.lazySingleton<_i19.ConnectToServer>(
        () => _i19.ConnectToServer(repository: gh<_i17.CommandsRepository>()));
    gh.lazySingleton<_i20.CreateServer>(
        () => _i20.CreateServer(repository: gh<_i17.CommandsRepository>()));
    gh.lazySingleton<_i21.DisconnectFromServer>(() =>
        _i21.DisconnectFromServer(repository: gh<_i17.CommandsRepository>()));
    gh.lazySingleton<_i22.GetPlayers>(
        () => _i22.GetPlayers(repository: gh<_i17.CommandsRepository>()));
    gh.lazySingleton<_i23.GetServers>(
        () => _i23.GetServers(repository: gh<_i17.CommandsRepository>()));
    gh.lazySingleton<_i24.ListenForserverConnection>(() =>
        _i24.ListenForserverConnection(
            repository: gh<_i17.CommandsRepository>()));
    gh.factory<_i25.NetworkDeviceBloc>(
        () => _i25.NetworkDeviceBloc(gh<_i23.GetServers>()));
    gh.factory<_i26.PlayersBloc>(() => _i26.PlayersBloc(gh<_i22.GetPlayers>()));
    gh.lazySingleton<_i27.SendMessage>(
        () => _i27.SendMessage(repository: gh<_i17.CommandsRepository>()));
    gh.lazySingleton<_i28.SetReady>(
        () => _i28.SetReady(repository: gh<_i17.CommandsRepository>()));
    gh.lazySingleton<_i29.CloseServer>(
        () => _i29.CloseServer(repository: gh<_i17.CommandsRepository>()));
    gh.factory<_i30.ConnectToServerBloc>(() => _i30.ConnectToServerBloc(
          gh<_i19.ConnectToServer>(),
          gh<_i27.SendMessage>(),
          gh<_i21.DisconnectFromServer>(),
          gh<_i24.ListenForserverConnection>(),
          gh<_i28.SetReady>(),
        ));
    gh.factory<_i31.CreateServerBloc>(() => _i31.CreateServerBloc(
          gh<_i20.CreateServer>(),
          gh<_i29.CloseServer>(),
        ));
    return this;
  }
}

class _$RegisterFToast extends _i32.RegisterFToast {}

class _$RegisterServer extends _i32.RegisterServer {}

class _$RegisterSharedPref extends _i32.RegisterSharedPref {}

class _$RegisterStoreRef extends _i32.RegisterStoreRef {}
