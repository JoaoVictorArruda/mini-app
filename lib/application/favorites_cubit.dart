import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefsKey = 'favorite_item_ids';

class FavoritesCubit extends Cubit<Set<String>> {
  FavoritesCubit(this._prefs) : super(<String>{}) {
    _load();
  }
  final SharedPreferences _prefs;

  void _load() {
    final saved = _prefs.getStringList(_prefsKey) ?? const <String>[];
    emit(saved.toSet());
  }

  Future<void> toggle(String id) async {
    final next = state.contains(id)
        ? (state.toSet()..remove(id))
        : (state.toSet()..add(id));
    emit(next);
    await _prefs.setStringList(_prefsKey, state.toList());
  }
}
