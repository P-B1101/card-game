// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:card_game/feature/commands/data/data_source/commands_data_source.dart'
    as _i7;
import 'package:card_game/feature/commands/data/repository/commands_repository_impl.dart'
    as _i16;
import 'package:card_game/feature/commands/domain/repository/commands_repository.dart'
    as _i15;
import 'package:card_game/feature/commands/domain/use_case/close_server.dart'
    as _i23;
import 'package:card_game/feature/commands/domain/use_case/connect_to_server.dart'
    as _i17;
import 'package:card_game/feature/commands/domain/use_case/create_server.dart'
    as _i18;
import 'package:card_game/feature/commands/domain/use_case/disconnect_from_server.dart'
    as _i19;
import 'package:card_game/feature/commands/domain/use_case/get_players.dart'
    as _i20;
import 'package:card_game/feature/commands/domain/use_case/send_message.dart'
    as _i22;
import 'package:card_game/feature/commands/presentation/bloc/connect_to_server_bloc.dart'
    as _i24;
import 'package:card_game/feature/commands/presentation/bloc/create_server_bloc.dart'
    as _i25;
import 'package:card_game/feature/commands/presentation/bloc/network_device_bloc.dart'
    as _i21;
import 'package:card_game/feature/database/data/data_source/database_data_source.dart'
    as _i8;
import 'package:card_game/feature/database/data/repository/database_repository_impl.dart'
    as _i10;
import 'package:card_game/feature/database/domain/repository/database_repository.dart'
    as _i9;
import 'package:card_game/feature/database/domain/use_case/get_username.dart'
    as _i11;
import 'package:card_game/feature/database/domain/use_case/save_username.dart'
    as _i13;
import 'package:card_game/feature/database/presentation/cubit/username_cubit.dart'
    as _i14;
import 'package:card_game/feature/repository_manager/repository_manager.dart'
    as _i12;
import 'package:card_game/injectable_container.dart' as _i26;
import 'package:fluttertoast/fluttertoast.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i5;
import 'package:socket_io/socket_io.dart' as _i4;
import 'package:socket_io_client/socket_io_client.dart' as _i6;

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
    final registerSocketIo = _$RegisterSocketIo();
    gh.lazySingleton<_i3.FToast>(() => registerFToast.tosat);
    gh.lazySingleton<_i4.Server>(() => registerServer.server);
    await gh.lazySingletonAsync<_i5.SharedPreferences>(
      () => registerSharedPref.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i6.Socket>(() => registerSocketIo.socket);
    gh.lazySingleton<_i7.CommandsDataSource>(() => _i7.CommandsDataSourceImpl(
          io: gh<_i4.Server>(),
          socket: gh<_i6.Socket>(),
        ));
    gh.lazySingleton<_i8.DataBaseDataSource>(() => _i8.DataBaseDataSourceImpl(
        sharedPreferences: gh<_i5.SharedPreferences>()));
    gh.lazySingleton<_i9.DatabaseRepository>(() =>
        _i10.DatabaseRepositoryImpl(dataSource: gh<_i8.DataBaseDataSource>()));
    gh.lazySingleton<_i11.GetUsername>(
        () => _i11.GetUsername(repository: gh<_i9.DatabaseRepository>()));
    gh.lazySingleton<_i12.RepositoryHelper>(() => _i12.RepositoryHelperImpl(
        databaseDataSource: gh<_i8.DataBaseDataSource>()));
    gh.lazySingleton<_i13.SaveUsername>(
        () => _i13.SaveUsername(repository: gh<_i9.DatabaseRepository>()));
    gh.factory<_i14.UsernameCubit>(() => _i14.UsernameCubit(
          gh<_i13.SaveUsername>(),
          gh<_i11.GetUsername>(),
        ));
    gh.lazySingleton<_i15.CommandsRepository>(() => _i16.CommandsRepositoryImpl(
          dataSource: gh<_i7.CommandsDataSource>(),
          repositoryHelper: gh<_i12.RepositoryHelper>(),
        ));
    gh.lazySingleton<_i17.ConnectToServer>(
        () => _i17.ConnectToServer(repository: gh<_i15.CommandsRepository>()));
    gh.lazySingleton<_i18.CreateServer>(
        () => _i18.CreateServer(repository: gh<_i15.CommandsRepository>()));
    gh.lazySingleton<_i19.DisconnectServer>(
        () => _i19.DisconnectServer(repository: gh<_i15.CommandsRepository>()));
    gh.lazySingleton<_i20.GetPlayers>(
        () => _i20.GetPlayers(repository: gh<_i15.CommandsRepository>()));
    gh.factory<_i21.NetworkDeviceBloc>(
        () => _i21.NetworkDeviceBloc(gh<_i20.GetPlayers>()));
    gh.lazySingleton<_i22.SendMessage>(
        () => _i22.SendMessage(repository: gh<_i15.CommandsRepository>()));
    gh.lazySingleton<_i23.CloseServer>(
        () => _i23.CloseServer(repository: gh<_i15.CommandsRepository>()));
    gh.factory<_i24.ConnectToServerBloc>(() => _i24.ConnectToServerBloc(
          gh<_i17.ConnectToServer>(),
          gh<_i22.SendMessage>(),
        ));
    gh.factory<_i25.CreateServerBloc>(() => _i25.CreateServerBloc(
          gh<_i18.CreateServer>(),
          gh<_i23.CloseServer>(),
        ));
    return this;
  }
}

class _$RegisterFToast extends _i26.RegisterFToast {}

class _$RegisterServer extends _i26.RegisterServer {}

class _$RegisterSharedPref extends _i26.RegisterSharedPref {}

class _$RegisterSocketIo extends _i26.RegisterSocketIo {}
