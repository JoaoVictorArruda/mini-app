import 'package:flutter/material.dart';
import 'package:mini_app/material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MiniApp(prefs: prefs));
}
