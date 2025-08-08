import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_app/application/favorites_cubit.dart';

class FavoritesBadgeWidget extends StatelessWidget {
  const FavoritesBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, Set<String>>(
      builder: (context, favorites) {
        return Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.favorite),
            Positioned(
              right: -2,
              top: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${favorites.length}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}