import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/meals.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]);

  // Method to toggle favorite status of a meal
  // If the meal is already in favorites, it will be removed; otherwise, it will be added.
  // This method is used to manage the state of favorite meals in the application.
  bool toggleFavorite(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false; // Meal is already a favorite, so we return false to indicate no change.
    } else {
      state = [...state, meal];
      return true; // Meal was not a favorite, so we return true to indicate it has been added.
    }
  }

  bool isFavorite(Meal meal) {
    return state.contains(meal);
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoritesNotifier, List<Meal>>((ref) {
      return FavoritesNotifier();
    });

//Use the Provider() method to create a provider that returns static data.
//Use ChangeNotifierProvider() for dynamic data that can change over time.
//Use StateNotifierProvider() for more complex state management with notifications.
