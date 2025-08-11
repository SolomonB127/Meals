import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/meals.dart';
import 'package:meals/providers/meals_provider.dart';

enum FilterOptions { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<FilterOptions, bool>> {
  FiltersNotifier()
    : super({
        FilterOptions.glutenFree: false,
        FilterOptions.lactoseFree: false,
        FilterOptions.vegetarian: false,
        FilterOptions.vegan: false,
      });

  void setFilters(Map<FilterOptions, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(FilterOptions option, bool isActive) {
    state = {...state, option: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<FilterOptions, bool>>((ref) {
      return FiltersNotifier();
    });

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[FilterOptions.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[FilterOptions.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[FilterOptions.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[FilterOptions.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
