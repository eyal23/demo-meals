import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_details_screen.dart';
import './screens/category_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filtersData) {
    if (filtersData != this._filters) {
      setState(() {
        this._filters = filtersData;

        this._availableMeals = DUMMY_MEALS.where(
          (meal) {
            if (this._filters['gluten'] && !meal.isGlutenFree ||
                this._filters['lactose'] && !meal.isLactoseFree ||
                this._filters['vegetarian'] && !meal.isVegetarian ||
                this._filters['vegan'] && !meal.isVegan) {
              return false;
            }
            return true;
          },
        ).toList();
      });
    }
  }

  void _toggleFavorite(String mealId) {
    final int existingIndex =
        this._favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex > -1) {
      setState(() {
        this._favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        this._favoriteMeals.add(
              DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),
            );
      });
    }
  }

  bool _isMealFavorite(String mealId) =>
      this._favoriteMeals.any((meal) => meal.id == mealId);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DeliMeals',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                body2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        routes: {
          '/': (ctx) => TabsScreen(this._favoriteMeals),
          CategoryMealsScreen.routeName: (ctx) =>
              CategoryMealsScreen(this._availableMeals),
          MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(
                toggleFavorite: this._toggleFavorite,
                isFavoriteMeal: this._isMealFavorite,
              ),
          FiltersScreen.routeName: (ctx) => FiltersScreen(
                currentFilters: this._filters,
                setFilters: this._setFilters,
              ),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => TabsScreen(this._favoriteMeals),
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
      body: Center(
        child: Text('Navigation Time!'),
      ),
    );
  }
}
