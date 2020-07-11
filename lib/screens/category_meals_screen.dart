import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const String routeName = '/category-meals';

  final List<Meal> availableMeals;

  const CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  List<Meal> _displayedMeals;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!this._loadedInitData) {
      final Map<String, String> routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      final String categoryId = routeArgs['id'];
      this._categoryTitle = routeArgs['title'];
      this._displayedMeals = widget.availableMeals.where(
        (meal) {
          return meal.categories.contains(categoryId);
        },
      ).toList();
      this._loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: _displayedMeals[index].id,
            title: _displayedMeals[index].title,
            imageUrl: _displayedMeals[index].imageUrl,
            duration: _displayedMeals[index].duration,
            complexity: _displayedMeals[index].complexity,
            affordability: _displayedMeals[index].affordability,
          );
        },
        itemCount: _displayedMeals.length,
      ),
    );
  }
}
