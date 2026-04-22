import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/sample_data.dart';
import '../models/stock_model.dart';
import 'stock_event.dart';
import 'stock_state.dart';
class StockBloc extends Bloc<StockEvent, StockState> {
  StockBloc()
      : super(
    StockState(
      watchlists: [
        generateRandomStocks(7),
        generateRandomStocks(5),
        generateRandomStocks(5),
      ],
      selectedTab: 0,
    ),
  ) {
    on<ChangeTab>((event, emit) {
      emit(state.copyWith(selectedTab: event.tabIndex));
    });
    on<ReorderStock>((event, emit) {
      final updatedWatchlists =
      List<List<Stock>>.from(state.watchlists);
      final currentList =
      List<Stock>.from(updatedWatchlists[state.selectedTab]);
      if (event.oldIndex < currentList.length) {
        final item = currentList.removeAt(event.oldIndex);
        currentList.insert(
          event.newIndex > event.oldIndex
              ? event.newIndex - 1
              : event.newIndex,
          item,
        );
      }
      updatedWatchlists[state.selectedTab] = currentList;
      emit(state.copyWith(watchlists: updatedWatchlists));
    });
    on<DeleteStock>((event, emit) {
      final updatedWatchlists =
      List<List<Stock>>.from(state.watchlists);
      final currentList =
      List<Stock>.from(updatedWatchlists[state.selectedTab]);
      if (event.index < currentList.length) {
        currentList.removeAt(event.index);
      }
      updatedWatchlists[state.selectedTab] = currentList;
      emit(state.copyWith(watchlists: updatedWatchlists));
    });
    on<SaveWatchlist>((event, emit) {
      final updatedWatchlists =
      List<List<Stock>>.from(state.watchlists);
      updatedWatchlists[state.selectedTab] = event.updatedList;
      emit(state.copyWith(watchlists: updatedWatchlists));
    });
    on<UpdatePrices>((event, emit) {
      final updatedWatchlists = state.watchlists.map((list) {
        return list.map((stock) {
          double randomChange = (random.nextDouble() * 2 - 1);
          double newPrice = stock.price + randomChange;
          double newPercent = (randomChange / stock.price) * 100;
          return stock.copyWith(
            price: double.parse(newPrice.toStringAsFixed(2)),
            change: double.parse(newPercent.toStringAsFixed(2)),
          );
        }).toList();
      }).toList();
      emit(state.copyWith(watchlists: updatedWatchlists));
    });
  }
}