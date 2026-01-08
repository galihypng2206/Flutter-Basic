import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 113, 0, 252)),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(255, 217, 189, 33),
      ),
      home: const MyHomePage(title: 'Test Integrasi API Middleware'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final ApiService api = ApiService();
  late Future<List<dynamic>> events;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    events = api.fetchEvents(0, 10); // ambil page=0 size=10
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text('Kamu sudah menekan tombol ini sebanyak:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Text('Kali'),

            const Divider(height: 40, thickness: 2),

            const Text(
              "Daftar Event Test:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: events, // pakai future yang sudah diset di initState
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Tidak ada event"));
                  } else {
                    final events = snapshot.data!;
                    return ListView.builder(
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return ListTile(
                          leading: const Icon(Icons.run_circle),
                          title: Text(event["eventTitle"] ?? "-"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(event["organizer"] ?? ""),
                              Text("Mulai: ${event["startDateTime"] ?? "-"}"),
                              Text("Selesai: ${event["endDateTime"] ?? "-"}"),
                            ],
                          ),
                        );
                      },
                    );
                  } 
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
