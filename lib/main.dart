import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const TidalStreamApp());
}

class TidalStreamApp extends StatelessWidget {
  const TidalStreamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueGrey[900],
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: const TidalCalculatorScreen(),
    );
  }
}

class TidalCalculatorScreen extends StatefulWidget {
  const TidalCalculatorScreen({super.key});

  @override
  State<TidalCalculatorScreen> createState() => _TidalCalculatorScreenState();
}

class _TidalCalculatorScreenState extends State<TidalCalculatorScreen> {
  final _maxSpeedController = TextEditingController();
  double _hoursAfterSlack = 0.0;
  double _calculatedSpeed = 0.0;

  void _calculateStream() {
    double maxSpeed = double.tryParse(_maxSpeedController.text) ?? 0.0;
    setState(() {
      _calculatedSpeed = maxSpeed * sin((_hoursAfterSlack / 6) * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚓ Tidal Stream Calculator'),
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'TidalStream Calculator',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(Icons.anchor, color: Colors.tealAccent, size: 40),
                children: [
                  const Text('A maritime navigation tool for Passage Planning using Sinusoidal Curve calculation.'),
                  const SizedBox(height: 15),
                  const Text('🧑‍💻 Program by: Renante Fullo', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              color: Colors.blueGrey[800],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'MAXIMUM STREAM SPEED',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.tealAccent),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _maxSpeedController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        hintText: '0.0',
                        suffixText: 'knots',
                        border: InputBorder.none,
                      ),
                      onChanged: (_) => _calculateStream(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'Time After Slack Water: ${_hoursAfterSlack.toStringAsFixed(1)} Hours',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            Slider(
              value: _hoursAfterSlack,
              min: 0.0,
              max: 6.0,
              divisions: 12,
              label: '${_hoursAfterSlack.toStringAsFixed(1)} hrs',
              activeColor: Colors.tealAccent,
              onChanged: (value) {
                setState(() {
                  _hoursAfterSlack = value;
                  _calculateStream();
                });
              },
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal[900]?.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.teal, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'ESTIMATED STREAM SPEED',
                      style: TextStyle(fontSize: 14, letterSpacing: 1.5, color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${_calculatedSpeed.toStringAsFixed(2)} kts',
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.tealAccent),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Heto ang tatak mo sa main screen Chief!
            const Text(
              '⚓ Program by: Renante Fullo',
              style: TextStyle(fontSize: 13, color: Colors.white38, fontStyle: FontStyle.italic),
              textAlign: Center,
            ),
          ],
        ),
      ),
    );
  }
}
