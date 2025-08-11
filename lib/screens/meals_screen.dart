import 'package:flutter/material.dart';
import 'package:meals/data/meals.dart';
import 'package:meals/screens/meals_details_screen.dart';
import 'package:meals/widgets/meal_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;


  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) =>
            MealsDetailsScreen(meal: meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget body = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectMeal: (meal) {
          selectMeal(context, meal);
        },
      ),
    );

    if (meals.isEmpty) {
      body = Center(
        child: Text(
          'Uh Oh.. Nothing here!.',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    }

    if (title == null) {
      return body;
    }

    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: body,
    );
  }
}
