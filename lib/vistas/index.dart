import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  const Index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(90, 7, 151, 187),
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
                  backgroundColor: Colors.white54,
                ),
                child: const Text('Entrar a la biblioteca',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto', 
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
