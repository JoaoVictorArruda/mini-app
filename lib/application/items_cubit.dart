import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_app/domain/item.dart';
import 'package:mini_app/repository/item_repository.dart';

sealed class ItemsState {
  const ItemsState();
}

class ItemsLoading extends ItemsState {
  const ItemsLoading();
}

class ItemsLoaded extends ItemsState {
  const ItemsLoaded(this.items);

  final List<Item> items;
}

class ItemsError extends ItemsState {
  const ItemsError(this.message);
  final String message;
}

class ItemsCubit extends Cubit<ItemsState> {
  ItemsCubit(this._api) : super(const ItemsLoading());
  final ItemRepository _api;

  Future<void> fetchItems() async {
    emit(const ItemsLoading());
    try {
      final items = await _api.fetchItems();
      emit(ItemsLoaded(items));
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }

  void filter(String value) async {
    emit(const ItemsLoading());
    try {
      final items = await _api.fetchItems(filter: value);
      emit(ItemsLoaded(items));
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }
}
