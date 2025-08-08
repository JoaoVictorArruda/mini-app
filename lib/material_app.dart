import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_app/application/favorites_cubit.dart';
import 'package:mini_app/application/items_cubit.dart';
import 'package:mini_app/presentation/home_screen.dart';
import 'package:mini_app/repository/item_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MiniApp extends StatelessWidget {
  const MiniApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ItemsCubit(ItemRepository())..fetchItems()),
          BlocProvider(create: (_) => FavoritesCubit(prefs)),
        ],
        child: MaterialApp(
          title: "Mini App",
          debugShowCheckedModeBanner: false,
          home: const HomeScreen()
        )
    );
  }
}
