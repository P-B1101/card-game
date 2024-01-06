// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:card_game/core/manager/network_manager.dart' as _i4;
import 'package:card_game/feature/commands/data/data_source/commands_data_source.dart'
    as _i17;
import 'package:card_game/feature/commands/data/repository/commands_repository_impl.dart'
    as _i19;
import 'package:card_game/feature/commands/domain/repository/commands_repository.dart'
    as _i18;
import 'package:card_game/feature/commands/domain/use_case/close_server.dart'
    as _i31;
import 'package:card_game/feature/commands/domain/use_case/connect_to_server.dart'
    as _i20;
import 'package:card_game/feature/commands/domain/use_case/create_server.dart'
    as _i21;
import 'package:card_game/feature/commands/domain/use_case/disconnect_from_server.dart'
    as _i22;
import 'package:card_game/feature/commands/domain/use_case/get_players.dart'
    as _i23;
import 'package:card_game/feature/commands/domain/use_case/get_servers.dart'
    as _i24;
import 'package:card_game/feature/commands/domain/use_case/listen_for_server_connection.dart'
    as _i25;
import 'package:card_game/feature/commands/domain/use_case/send_message.dart'
    as _i28;
import 'package:card_game/feature/commands/domain/use_case/set_ready.dart'
    as _i29;
import 'package:card_game/feature/commands/domain/use_case/start_game.dart'
    as _i30;
import 'package:card_game/feature/commands/presentation/bloc/connect_to_server_bloc.dart'
    as _i32;
import 'package:card_game/feature/commands/presentation/bloc/create_server_bloc.dart'
    as _i33;
import 'package:card_game/feature/commands/presentation/bloc/network_device_bloc.dart'
    as _i26;
import 'package:card_game/feature/commands/presentation/bloc/players_bloc.dart'
    as _i27;
import 'package:card_game/feature/database/data/data_source/database_data_source.dart'
    as _i9;
import 'package:card_game/feature/database/data/data_source/sembast_data_source.dart'
    as _i15;
import 'package:card_game/feature/database/data/repository/database_repository_impl.dart'
    as _i11;
import 'package:card_game/feature/database/domain/repository/database_repository.dart'
    as _i10;
import 'package:card_game/feature/database/domain/use_case/get_username.dart'
    as _i12;
import 'package:card_game/feature/database/domain/use_case/save_username.dart'
    as _i14;
import 'package:card_game/feature/database/presentation/cubit/username_cubit.dart'
    as _i16;
import 'package:card_game/feature/menu/presentation/cubit/start_game_cubit.dart'
    as _i7;
import 'package:card_game/feature/repository_manager/repository_manager.dart'
    as _i13;
import 'package:card_game/injectable_container.dart' as _i34;
import 'package:fluttertoast/fluttertoast.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i8;
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
    gh.factory<_i7.StartGameCubit>(() => _i7.StartGameCubit());
    gh.lazySingleton<_i8.StoreRef<Object?, Object?>>(
        () => registerStoreRef.store);
    gh.lazySingleton<_i9.DataBaseDataSource>(() => _i9.DataBaseDataSourceImpl(
        sharedPreferences: gh<_i6.SharedPreferences>()));
    gh.lazySingleton<_i10.DatabaseRepository>(() => _i11.DatabaseRepositoryImpl(
          dataSource: gh<_i9.DataBaseDataSource>(),
          networkManager: gh<_i4.NetworkManager>(),
        ));
    gh.lazySingleton<_i12.GetUsername>(
        () => _i12.GetUsername(repository: gh<_i10.DatabaseRepository>()));
    gh.lazySingleton<_i13.RepositoryHelper>(() => _i13.RepositoryHelperImpl(
        databaseDataSource: gh<_i9.DataBaseDataSource>()));
    gh.lazySingleton<_i14.SaveUsername>(
        () => _i14.SaveUsername(repository: gh<_i10.DatabaseRepository>()));
    gh.lazySingleton<_i15.SembastDataSource>(() => _i15.SembastDataSourceImpl(
        store: gh<_i8.StoreRef<Object?, Object?>>()));
    gh.factory<_i16.UsernameCubit>(() => _i16.UsernameCubit(
          gh<_i14.SaveUsername>(),
          gh<_i4.NetworkManager>(),
          gh<_i12.GetUsername>(),
        ));
    gh.lazySingleton<_i17.CommandsDataSource>(() => _i17.CommandsDataSourceImpl(
          server: gh<_i5.Server>(),
          networkManager: gh<_i4.NetworkManager>(),
          sembastDataSource: gh<_i15.SembastDataSource>(),
        ));
    gh.lazySingleton<_i18.CommandsRepository>(() => _i19.CommandsRepositoryImpl(
          dataSource: gh<_i17.CommandsDataSource>(),
          repositoryHelper: gh<_i13.RepositoryHelper>(),
          networkManager: gh<_i4.NetworkManager>(),
        ));
    gh.lazySingleton<_i20.ConnectToServer>(
        () => _i20.ConnectToServer(repository: gh<_i18.CommandsRepository>()));
    gh.lazySingleton<_i21.CreateServer>(
        () => _i21.CreateServer(repository: gh<_i18.CommandsRepository>()));
    gh.lazySingleton<_i22.DisconnectFromServer>(() =>
        _i22.DisconnectFromServer(repository: gh<_i18.CommandsRepository>()));
    gh.lazySingleton<_i23.GetPlayers>(
        () => _i23.GetPlayers(repository: gh<_i18.CommandsRepository>()));
    gh.lazySingleton<_i24.GetServers>(
        () => _i24.GetServers(repository: gh<_i18.CommandsRepository>()));
    gh.lazySingleton<_i25.ListenForserverConnection>(() =>
        _i25.ListenForserverConnection(
            repository: gh<_i18.CommandsRepository>()));
    gh.factory<_i26.NetworkDeviceBloc>(
        () => _i26.NetworkDeviceBloc(gh<_i24.GetServers>()));
    gh.factory<_i27.PlayersBloc>(() => _i27.PlayersBloc(gh<_i23.GetPlayers>()));
    gh.lazySingleton<_i28.SendMessage>(
        () => _i28.SendMessage(repository: gh<_i18.CommandsRepository>()));
    gh.lazySingleton<_i29.SetReady>(
        () => _i29.SetReady(repository: gh<_i18.CommandsRepository>()));
    gh.lazySingleton<_i30.StartGame>(
        () => _i30.StartGame(repository: gh<_i18.CommandsRepository>()));
    gh.lazySingleton<_i31.CloseServer>(
        () => _i31.CloseServer(repository: gh<_i18.CommandsRepository>()));
    gh.factory<_i32.ConnectToServerBloc>(() => _i32.ConnectToServerBloc(
          gh<_i20.ConnectToServer>(),
          gh<_i28.SendMessage>(),
          gh<_i22.DisconnectFromServer>(),
          gh<_i25.ListenForserverConnection>(),
          gh<_i29.SetReady>(),
          gh<_i30.StartGame>(),
        ));
    gh.factory<_i33.CreateServerBloc>(() => _i33.CreateServerBloc(
          gh<_i21.CreateServer>(),
          gh<_i31.CloseServer>(),
        ));
    return this;
  }
}

class _$RegisterFToast extends _i34.RegisterFToast {}

class _$RegisterServer extends _i34.RegisterServer {}

class _$RegisterSharedPref extends _i34.RegisterSharedPref {}

class _$RegisterStoreRef extends _i34.RegisterStoreRef {}
