import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';


final mealsProvider = Provider((ref) {
  return dummyMeals;
});

//Use the Provider() method to create a provider that returns static data.
//Use ChangeNotifierProvider() for dynamic data that can change over time.
//Use StateNotifierProvider() for more complex state management with notifications.
