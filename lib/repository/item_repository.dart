import 'package:mini_app/domain/item.dart';

class ItemRepository {

  Future<List<Item>> fetchItems({String filter = ''}) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final now  = DateTime.now();
    Iterable<Item> filtered = [
      Item(id: '1', title: 'Feature', tag: 'new', addedAt: now.subtract(Duration(seconds: 5))),
      Item(id: '2', title: 'Outdated', tag: 'old', addedAt: now.subtract(Duration(seconds: 10))),
      Item(id: '3', title: 'Brand', tag: 'hot', addedAt: now.subtract(Duration(seconds: 15))),
      Item(id: '4', title: 'Aged', tag: 'old', addedAt: now.subtract(Duration(seconds: 25))),
      Item(id: '5', title: 'Young', tag: 'new', addedAt: now.subtract(Duration(seconds: 35)))
    ];
    if(filter.isNotEmpty) {
      filtered = filtered.where((element) => element.title.toLowerCase().contains(filter.toLowerCase()));
    }
    return filtered.toList();
  }

}