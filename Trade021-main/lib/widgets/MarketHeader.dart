import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class MarketHeader extends StatefulWidget {
  const MarketHeader({super.key});

  @override
  State<MarketHeader> createState() => _MarketHeaderState();
}

class _MarketHeaderState extends State<MarketHeader> {
  double sensexPrice = 1225.55;
  double sensexChange = 144.50;
  double niftyPrice = 54173.20;
  double niftyChange = -13.70;
  late Timer timer;
  final random = Random();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    // Prevent layout jump
    await Future.delayed(Duration(milliseconds: 500));
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
    
    timer = Timer.periodic(Duration(seconds: 2), (_) {
      if (!mounted) return;
      setState(() {
        sensexPrice += random.nextDouble() * 10 - 5;
        sensexChange += random.nextDouble() * 4 - 2;
        niftyPrice += random.nextDouble() * 20 - 10;
        niftyChange += random.nextDouble() * 6 - 3;
      });
    });
  }

  @override
  void dispose() {
    if (isLoading == false) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        height: 80,
        alignment: Alignment.center,
        color: Colors.white,
        child: Text("Loading indices..."),
      );
    }

    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _marketItem(
            "SENSEX",
            sensexPrice.toStringAsFixed(2),
            sensexChange.toStringAsFixed(2),
            sensexChange >= 0,
          ),
          Container(height: 60, width: 1, color: Colors.black),
          Row(
            children: [
              _marketItem(
                "NIFTY BANK",
                niftyPrice.toStringAsFixed(2),
                niftyChange.toStringAsFixed(2),
                niftyChange >= 0,
              ),
              SizedBox(width: 6),
              Icon(Icons.arrow_forward_ios, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _marketItem(String title, String price, String change, bool isUp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(price),
        Text(
          change,
          style: TextStyle(
            color: isUp ? Colors.green : Colors.red,
          ),
        ),
      ],
    );
  }
}