import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/theme/theme.dart';

import 'models/product_list.dart';
import 'screens/home_screen.dart';
import 'screens/product_details.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductList(),
      child: MaterialApp(
        title: 'Shopping App',
        debugShowCheckedModeBanner: false,
        theme: purpleLightTheme,
        darkTheme: purpleDarkTheme,
        themeMode: ThemeMode.system,
        home: const MyHomePage(title: 'Minha Loja'),
        routes: {
          AppRoutes.productDetails: (context) => const ProductDetails(),
        },
      ),
    );
  }
}
