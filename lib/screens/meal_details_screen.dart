import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const String routeName = "/meal-details";

  final Function toggleFavorite;
  final Function isFavoriteMeal;

  const MealDetailsScreen({
    @required this.toggleFavorite,
    @required this.isFavoriteMeal,
  });

  Container buildSectionTitle({
    @required BuildContext context,
    @required String title,
  }) =>
      Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.title,
        ),
      );

  Container buildContainer({
    @required Widget child,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        width: 300,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context).settings.arguments as String;
    final Meal selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            this.buildSectionTitle(
              context: context,
              title: "Ingredients",
            ),
            this.buildContainer(
              child: ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(selectedMeal.ingredients[index]),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            this.buildSectionTitle(
              context: context,
              title: "Steps",
            ),
            this.buildContainer(
              child: ListView.builder(
                itemBuilder: (ctx, index) => Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        child: Text("# ${index + 1}"),
                      ),
                      title: Text(selectedMeal.steps[index]),
                    ),
                    Divider(
                      color: Colors.black,
                    ),
                  ],
                ),
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => this.toggleFavorite(mealId),
        child: Icon(
          this.isFavoriteMeal(mealId) ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
