import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_ecommerce/data/store.dart';
import 'package:provider_ecommerce/screens/home/home_screen.dart';
import 'package:provider_ecommerce/screens/product_detail/detail_screen.dart';
import 'package:provider_ecommerce/theme/theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Store(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Provider Ecommerce',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (_) => const HomeScreen(),
          '/detail': (_) => const DetailScreen(),
        },
      ),
    );
  }
}
