import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io/socket_io.dart';

import 'injectable_container.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  await getIt.init();
}

// @module
// abstract class RegisterNetworkInfo {
//   @lazySingleton
//   InternetConnectionChecker get info => InternetConnectionChecker();
// }

@module
abstract class RegisterSharedPref {
  @lazySingleton
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

@module
abstract class RegisterFToast {
  @lazySingleton
  FToast get tosat => FToast();
}

@module
abstract class RegisterServer {
  @lazySingleton
  Server get server => Server();
}

@module
abstract class RegisterStoreRef {
  @lazySingleton
  StoreRef get store => StoreRef.main();
}



// @module
// abstract class RegisterSocketIo {
//   @lazySingleton
//   socket_io.Socket get socket => socket_io.io(
//         'http://localhost:1212/card-game',
//         socket_io.OptionBuilder().setTransports(['websocket']).build(),
//       );
// }
