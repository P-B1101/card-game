import 'package:card_game/feature/commands/presentation/bloc/connect_to_server_bloc.dart';
import 'package:card_game/feature/commands/presentation/bloc/create_server_bloc.dart';
import 'package:card_game/injectable_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../core/utils/assets.dart';
import '../../core/utils/extensions.dart';
import '../language/manager/localizatios.dart';
import 'app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateServerBloc>(
          create: (context) => getIt<CreateServerBloc>(),
        ),
        BlocProvider<ConnectToServerBloc>(
          create: (context) => getIt<ConnectToServerBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: MColors.primaryColor,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          fontFamily: Fonts.yekan,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: MColors.primaryColor,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
          fontFamily: Fonts.yekan,
        ),
        onGenerateTitle: (context) => Strings.of(context).app_name,
        themeMode: ThemeMode.light,
        builder: (context, child) {
          final MediaQueryData data = MediaQuery.of(context);
          final scaleFactor = data.size.width.scaleFactor;
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: Theme.of(context).brightness == Brightness.light
                ? SystemUiOverlayStyle.dark.copyWith(
                    statusBarColor: Colors.transparent,
                  )
                : SystemUiOverlayStyle.light.copyWith(
                    statusBarColor: Colors.transparent,
                  ),
            child: MediaQuery(
              data: data.copyWith(
                textScaler: TextScaler.linear(scaleFactor),
                boldText: false,
              ),
              child: child!,
            ),
          );
        },
        locale: const Locale('fa'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          Intl.defaultLocale = 'fa';
          return const Locale('fa');
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
