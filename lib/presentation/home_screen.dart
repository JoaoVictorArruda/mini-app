import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_app/application/favorites_cubit.dart';
import 'package:mini_app/application/items_cubit.dart';
import 'package:mini_app/presentation/widgets/favorites_badge_widget.dart';
import 'package:mini_app/presentation/widgets/tag_chip_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ItemsCubit, ItemsState>(
              builder: (context, state) {
                return TextFormField(
                  decoration: InputDecoration(
                    hintTextDirection: TextDirection.ltr,
                    labelText: "Search",
                    hintText: "Name",
                  ),
                  onChanged: (value) => context.read<ItemsCubit>().filter(value),
                );
          }),
          actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: FavoritesBadgeWidget(),
          ),
        ],
      ),
      body: BlocBuilder<ItemsCubit, ItemsState>(
        builder: (context, state) {
          return switch (state) {
            ItemsLoading() => const Center(child: CircularProgressIndicator()),
            ItemsError(:final message) => Center(child: Text('Error: $message')),
            ItemsLoaded(:final items) => RefreshIndicator(
              onRefresh: () => context.read<ItemsCubit>().fetchItems(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: items.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return BlocBuilder<FavoritesCubit, Set<String>>(
                    buildWhen: (prev, next) => prev.contains(item.id) != next.contains(item.id),
                    builder: (context, favorites) {
                      final isFav = favorites.contains(item.id);
                      return ListTile(
                        leading: TagChipWidget(tag: item.tag),
                        title: Text(item.title),
                        subtitle: Text(_timeSince(item.addedAt)),
                        trailing: IconButton(
                          tooltip: isFav ? 'Unfavorite' : 'Favorite',
                          icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                          color: isFav ? Theme.of(context).colorScheme.primary : null,
                          onPressed: () => context.read<FavoritesCubit>().toggle(item.id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          };
        },
      ),
    );
  }

  String _timeSince(DateTime past) {
    final now = DateTime.now();
    final diff = now.difference(past);
    return '${diff.inSeconds}s ago';
  }
}
