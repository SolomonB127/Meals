import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/data/meals.dart';
import 'package:meals/model/category.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  // AnimationController is used for animations in Flutter.
  // It controls the animation's duration, status, and value.
  //If multiple animations controllers are needed the TickerProviderStateMixin is used.
  // In this case, SingleTickerProviderStateMixin is used because only one animation controller is needed.
  // The vsync parameter is used to optimize the animation performance.
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    // Initialize the animation controller if needed
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    _animationController.forward(); // Start the animation
    // You can also use _animationController.repeat() to repeat the animation
  }

  @override
  void dispose() {
    // Dispose of the animation controller to free up resources
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        // Filter meals based on the selected category
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    // Navigate to the meals screen for the selected category
    //Navigator.of(context).push() can also be used instead of Navigator.push()
    // to push a new route onto the navigator stack.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) =>
            MealsScreen(meals: filteredMeals, title: category.title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,

      child: GridView(
        padding: const EdgeInsets.all(24.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          //The for..in loop is an alternative to using map() for creating a list of widgets.
          /*availableCategories.map((category) {
              return CategoryGridItem(category: category);
            }).toList(),*/
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
      builder: (context, child) => SlideTransition(
        position:
            Tween(
              begin: const Offset(0.0, 0.3),
              end: const Offset(0.0, 0.0),
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),
        child: child,
      ),
    );
  }
}
