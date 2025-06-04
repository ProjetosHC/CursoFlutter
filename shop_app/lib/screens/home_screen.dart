import 'package:flutter/material.dart';

import '../components/product_gridview.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum FilterOptions { all, favorites }

class _MyHomePageState extends State<MyHomePage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Favoritos'),
              ),
            ],
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.favorites) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
        ],
      ),
      body: ProductGridView(showFavoriteOnly: _showFavoriteOnly),
    );
  }
}
