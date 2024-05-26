import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Biblioteca Shadai 📚✨'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            //    Container(
            //     decoration: const BoxDecoration(
            //     image: DecorationImage(
            //     image: AssetImage("/Images/fondoindex.jpg"),
            //     fit: BoxFit.cover, 
            //     ),
            //   ),
            // ),
              const Text(
                'Bienvenidos a nuestra Biblioteca',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Comencemos'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
