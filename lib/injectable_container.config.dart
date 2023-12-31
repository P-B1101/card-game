// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:card_game/core/manager/network_manager.dart' as _i5;
import 'package:card_game/feature/commands/data/data_source/commands_data_source.dart'
    as _i9;
import 'package:card_game/feature/commands/data/repository/commands_repository_impl.dart'
    as _i18;
import 'package:card_game/feature/commands/domain/repository/commands_repository.dart'
    as _i17;
import 'package:card_game/feature/commands/domain/use_case/close_server.dart'
    as _i25;
import 'package:card_game/feature/commands/domain/use_case/connect_to_server.dart'
    as _i19;
import 'package:card_game/feature/commands/domain/use_case/create_server.dart'
    as _i20;
import 'package:card_game/feature/commands/domain/use_case/disconnect_from_server.dart'
    as _i21;
import 'package:card_game/feature/commands/domain/use_case/get_players.dart'
    as _i22;
import 'package:card_game/feature/commands/domain/use_case/send_message.dart'
    as _i24;
import 'package:card_game/feature/commands/presentation/bloc/connect_to_server_bloc.dart'
    as _i26;
import 'package:card_game/feature/commands/presentation/bloc/create_server_bloc.dart'
    as _i27;
import 'package:card_game/feature/commands/presentation/bloc/network_device_bloc.dart'
    as _i23;
import 'package:card_game/feature/database/data/data_source/database_data_source.dart'
    as _i10;
import 'package:card_game/feature/database/data/repository/database_repository_impl.dart'
    as _i12;
import 'package:card_game/feature/database/domain/repository/database_repository.dart'
    as _i11;
import 'package:card_game/feature/database/domain/use_case/get_username.dart'
    as _i13;
import 'package:card_game/feature/database/domain/use_case/save_username.dart'
    as _i15;
import 'package:card_game/feature/database/presentation/cubit/username_cubit.dart'
    as _i16;
import 'package:card_game/feature/repository_manager/repository_manager.dart'
    as _i14;
import 'package:card_game/injectable_container.dart' as _i28;
import 'package:fluttertoast/fluttertoast.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:network_info_plus/network_info_plus.dart' as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i7;
import 'package:socket_io/socket_io.dart' as _i6;
import 'package:socket_io_client/socket_io_client.dart' as _i8;

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
    final registerNetworkInfo = _$RegisterNetworkInfo();
    final registerServer = _$RegisterServer();
    final registerSharedPref = _$RegisterSharedPref();
    final registerSocketIo = _$RegisterSocketIo();
    gh.lazySingleton<_i3.FToast>(() => registerFToast.tosat);
    gh.lazySingleton<_i4.NetworkInfo>(() => registerNetworkInfo.info);
    gh.lazySingleton<_i5.NetworkManager>(
        () => _i5.NetworkManagerImpl(info: gh<_i4.NetworkInfo>()));
    gh.lazySingleton<_i6.Server>(() => registerServer.server);
    await gh.lazySingletonAsync<_i7.SharedPreferences>(
      () => registerSharedPref.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i8.Socket>(() => registerSocketIo.socket);
    gh.lazySingleton<_i9.CommandsDataSource>(() => _i9.CommandsDataSourceImpl(
          io: gh<_i6.Server>(),
          socket: gh<_i8.Socket>(),
        ));
    gh.lazySingleton<_i10.DataBaseDataSource>(() => _i10.DataBaseDataSourceImpl(
        sharedPreferences: gh<_i7.SharedPreferences>()));
    gh.lazySingleton<_i11.DatabaseRepository>(() =>
        _i12.DatabaseRepositoryImpl(dataSource: gh<_i10.DataBaseDataSource>()));
    gh.lazySingleton<_i13.GetUsername>(
        () => _i13.GetUsername(repository: gh<_i11.DatabaseRepository>()));
    gh.lazySingleton<_i14.RepositoryHelper>(() => _i14.RepositoryHelperImpl(
        databaseDataSource: gh<_i10.DataBaseDataSource>()));
    gh.lazySingleton<_i15.SaveUsername>(
        () => _i15.SaveUsername(repository: gh<_i11.DatabaseRepository>()));
    gh.factory<_i16.UsernameCubit>(() => _i16.UsernameCubit(
          gh<_i15.SaveUsername>(),
          gh<_i13.GetUsername>(),
        ));
    gh.lazySingleton<_i17.CommandsRepository>(() => _i18.CommandsRepositoryImpl(
          dataSource: gh<_i9.CommandsDataSource>(),
          repositoryHelper: gh<_i14.RepositoryHelper>(),
        ));
    gh.lazySingleton<_i19.ConnectToServer>(
        () => _i19.ConnectToServer(repository: gh<_i17.CommandsRepository>()));
    gh.lazySingleton<_i20.CreateServer>(
        () => _i20.CreateServer(repository: gh<_i17.CommandsRepository>()));
    gh.lazySingleton<_i21.DisconnectServer>(
        () => _i21.DisconnectServer(repository: gh<_i17.CommandsRepository>()));
    gh.lazySingleton<_i22.GetPlayers>(
        () => _i22.GetPlayers(repository: gh<_i17.CommandsRepository>()));
    gh.factory<_i23.NetworkDeviceBloc>(
        () => _i23.NetworkDeviceBloc(gh<_i22.GetPlayers>()));
    gh.lazySingleton<_i24.SendMessage>(
        () => _i24.SendMessage(repository: gh<_i17.CommandsRepository>()));
    gh.lazySingleton<_i25.CloseServer>(
        () => _i25.CloseServer(repository: gh<_i17.CommandsRepository>()));
    gh.factory<_i26.ConnectToServerBloc>(() => _i26.ConnectToServerBloc(
          gh<_i19.ConnectToServer>(),
          gh<_i24.SendMessage>(),
        ));
    gh.factory<_i27.CreateServerBloc>(() => _i27.CreateServerBloc(
          gh<_i20.CreateServer>(),
          gh<_i25.CloseServer>(),
        ));
    return this;
  }
}

class _$RegisterFToast extends _i28.RegisterFToast {}

class _$RegisterNetworkInfo extends _i28.RegisterNetworkInfo {}

class _$RegisterServer extends _i28.RegisterServer {}

class _$RegisterSharedPref extends _i28.RegisterSharedPref {}

class _$RegisterSocketIo extends _i28.RegisterSocketIo {}
