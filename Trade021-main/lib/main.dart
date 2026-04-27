import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/stock_bloc.dart';
import 'bloc/stock_event.dart';
import 'repositories/market_repository.dart';
import 'screens/watchlist_screen.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // Logging state transitions cleanly
    debugPrint('${bloc.runtimeType} $change');
  }
}

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(
    RepositoryProvider(
      create: (context) => MarketRepository(),
      child: BlocProvider<StockBloc>(
        create: (context) => StockBloc(
          marketRepository: context.read<MarketRepository>(),
        )..add(const LoadStocksRequested()),
        child: TradeTrackerApp(),
      ),
    ),
  );
}

class TradeTrackerApp extends StatelessWidget {
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