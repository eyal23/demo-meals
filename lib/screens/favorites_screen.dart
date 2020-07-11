import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoritesScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    if (this.favoriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: this.favoriteMeals[index].id,
            title: this.favoriteMeals[index].title,
            imageUrl: this.favoriteMeals[index].imageUrl,
            duration: this.favoriteMeals[index].duration,
            complexity: this.favoriteMeals[index].complexity,
            affordability: this.favoriteMeals[index].affordability,
          );
        },
        itemCount: this.favoriteMeals.length,
      );
    }
  }
}
