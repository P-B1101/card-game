import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Strings {
  static final Strings _singleton = Strings._internal();

  factory Strings() => _singleton;

  Strings._internal();

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context)!;
}
