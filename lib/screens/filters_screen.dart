import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = '/filters';

  final Function setFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen({
    @required this.currentFilters,
    @required this.setFilters,
  });

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    this._glutenFree = widget.currentFilters['gluten'];
    this._lactoseFree = widget.currentFilters['lactose'];
    this._vegetarian = widget.currentFilters['vegetarian'];
    this._vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  SwitchListTile _buildSwitchListTile({
    @required String title,
    @required String subtitle,
    @required bool currentValue,
    @required Function updateValue,
  }) =>
      SwitchListTile(
        value: currentValue,
        onChanged: updateValue,
        title: Text(title),
        subtitle: Text(subtitle),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final Map<String, bool> selectedFilters = {
                'gluten': this._glutenFree,
                'lactose': this._lactoseFree,
                'vegetarian': this._vegetarian,
                'vegan': this._vegan,
              };
              widget.setFilters(selectedFilters);
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                this._buildSwitchListTile(
                  title: 'Gluten-free',
                  subtitle: 'Only include gluten-free meals',
                  currentValue: this._glutenFree,
                  updateValue: (newValue) {
                    setState(() {
                      this._glutenFree = newValue;
                    });
                  },
                ),
                this._buildSwitchListTile(
                  title: 'Lactose-free',
                  subtitle: 'Only include lactose-free meals',
                  currentValue: this._lactoseFree,
                  updateValue: (newValue) {
                    setState(() {
                      this._lactoseFree = newValue;
                    });
                  },
                ),
                this._buildSwitchListTile(
                  title: 'Vegetarian',
                  subtitle: 'Only include vegetatian meals',
                  currentValue: this._vegetarian,
                  updateValue: (newValue) {
                    setState(() {
                      this._vegetarian = newValue;
                    });
                  },
                ),
                this._buildSwitchListTile(
                  title: 'Vegan',
                  subtitle: 'Only include vegan meals',
                  currentValue: this._vegan,
                  updateValue: (newValue) {
                    setState(() {
                      this._vegan = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
