import 'package:flutter/material.dart';
import 'feature/router/my_app.dart';
import 'injectable_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}
