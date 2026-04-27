# Trade Tracker

A minimal, real-time stock watchlist clone built with Flutter to practice state management and UI design.

---

##  About the Project
I wanted to build a UI that feels like a real stock trading app (inspired heavily by Zerodha Kite). The main goal was to understand how to handle rapidly updating data (like stock prices) without making the UI freeze, while keeping the state clean across multiple screens. 

Instead of building a full trading platform, this focuses purely on the "Watchlist" experience—managing multiple lists, reordering items, and dealing with simulated live market data.

---

## Tech Stack
- Flutter
- Dart
- `flutter_bloc` (State management)

---

## Features
- **Multiple Watchlists**: Switch between different watchlists (Watchlist 1, 5, 6) seamlessly.
- **Simulated Live Market Data**: Polling mechanism that artificially updates stock prices and percentages to mimic market volatility.
- **Drag & Drop Reordering**: Long press and drag to reorder instruments exactly how you want them.
- **Edit Mode**: Delete stocks from your active list easily.
- **Clean UI**: Bottom navigation and tab-based layout that feels native and intuitive.

---

## Project Structure 
- `/lib/bloc` - Contains the `StockBloc`, events, and state for handling watchlist data and UI updates.
- `/lib/screens` - Main UI views (`home_screen`, `watchlist_screen`, `edit_watchlist_screen`).
- `/lib/repositories` - Mock market repository that simulates network latency and price fluctuations.
- `/lib/models` - Data models for `Stock` items.
- `/lib/widgets` - Reusable UI components like the `StockTile` and `MarketHeader`.

---

##  Installation & Setup
1. Clone the repo:
   ```bash
   git clone https://github.com/yourusername/trade021.git
   cd trade021
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```
*(Note: Tested on iOS/Android emulators, but should work fine on the web too).*

---

## Challenges / Learnings
- **BLoC State with Lists**: Managing nested lists (list of watchlists) inside BLoC was a bit of a headache. I initially struggled with state not updating when reordering stocks because Dart lists are passed by reference. I had to make sure I was creating new list instances (`List.from()`) before emitting the new state.
- **Reorder Bug**: The drag-and-drop reorder logic was tricky to get right. I ended up putting a quick fix directly in the BLoC, though ideally, that logic should probably live in the repository or a separate use-case layer.
- **Network Failures**: I added artificial timeouts in the repository to simulate real-world API failures. Right now the BLoC just silently catches the exception to prevent crashes, but it was a good exercise in handling async streams gracefully.

---

## Future Improvements
- Wire up the search bar (currently just a UI placeholder).
- Use `shared_preferences` to actually save the watchlists locally so they survive an app restart.
- Add real Snackbar error handling when the simulated network request fails instead of failing silently.
- Integrate a real financial API (like Yahoo Finance or Alpha Vantage) instead of mock data.
