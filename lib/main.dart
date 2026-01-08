import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 33, 174, 217),
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) _counter--;
    });
  }

  void _confirmResetCounter() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Konfirmasi'), 
        content: const Text('Yakin mau reset?'),
        actions: [
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // tutup dialog (Tidak)
                },
                child: const Text('Tidak'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counter = 0;
                  });
                  Navigator.of(context).pop(); // tutup dialog (Ya)
                },
                child: const Text('Ya'),
              ),
            ],
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Counter'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nilai Counter:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              '$_counter',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 251, 71),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _decrementCounter,
                  child: const Icon(Icons.remove_circle_outline),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _confirmResetCounter,
                  child: const Icon(Icons.refresh),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _incrementCounter,
                  child: const Icon(Icons.add_card_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
