import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
  home: Home(),
));

// whenever we make changes to the widget tree, flutter detects it and triggers the build()
// this eliminates the need to manually trigger the hot reload
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('my first flutter app'),
        centerTitle: true,
        backgroundColor: Colors.red[600],
      ),
      body: const Center(
        child: ElevatedButton(
            onPressed: null,
            child: Text('click me'),
            )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.red[600],
        child: const Text('click'),
      ),
    );
  }
}