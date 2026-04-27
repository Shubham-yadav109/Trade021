import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/stock_model.dart';
import '../repositories/market_repository.dart';
import 'stock_event.dart';
import 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final MarketRepository marketRepository;

  StockBloc({required this.marketRepository})
      : super(
    StockState(
      watchlists: [[], [], []],
      selectedTab: 0,
    ),
  ) {
    on<WatchlistTabChanged>((event, emit) {
      emit(state.copyWith(selectedTab: event.tabIndex));
    });

    on<ReorderStockRequested>((event, emit) {
      // Quick fix for the reorder bug, need to move this to a repository later
      final updatedWatchlists = List<List<Stock>>.from(state.watchlists);
      
      final List<Stock> tempList = [];
      tempList.addAll(updatedWatchlists[state.selectedTab]);
      
      if (event.oldIndex < tempList.length) {
        final item = tempList.removeAt(event.oldIndex);
        tempList.insert(
          event.newIndex > event.oldIndex
              ? event.newIndex - 1
              : event.newIndex,
          item,
        );
      }
      updatedWatchlists[state.selectedTab] = tempList;
      emit(state.copyWith(watchlists: updatedWatchlists));
    });

    on<DeleteStockRequested>((event, emit) {
      final updatedWatchlists = List<List<Stock>>.from(state.watchlists);
      final currentList = List<Stock>.from(updatedWatchlists[state.selectedTab]);
      
      if (event.index < currentList.length) {
        currentList.removeAt(event.index);
      }
      updatedWatchlists[state.selectedTab] = currentList;
      emit(state.copyWith(watchlists: updatedWatchlists));
    });

    on<SaveWatchlistRequested>((event, emit) {
      final updatedWatchlists = List<List<Stock>>.from(state.watchlists);
      updatedWatchlists[state.selectedTab] = event.updatedList;
      emit(state.copyWith(watchlists: updatedWatchlists));
    });

    on<RefreshPricesRequested>((event, emit) async {
      try {
        final updatedWatchlists = await marketRepository.fetchUpdatedPrices(state.watchlists);
        emit(state.copyWith(watchlists: updatedWatchlists));
      } on Exception catch (_) {
        // Silently fail on network issues and keep old data, 
        // probably should show a snackbar instead.
      }
    });

    on<LoadStocksRequested>((event, emit) async {
       try {
         final initialWatchlists = await marketRepository.fetchInitialWatchlists();
         emit(state.copyWith(watchlists: initialWatchlists));
       } catch (_) {
         // handle error
       }
    });
  }
}