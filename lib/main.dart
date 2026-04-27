import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade/screens/watchlist_screen.dart';
import 'bloc/stock_bloc.dart';
void main() {
  runApp(
    BlocProvider<StockBloc>(
      create: (_) => StockBloc(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MainPage(),
    );
  }
}