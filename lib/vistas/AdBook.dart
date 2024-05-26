import 'package:flutter/material.dart';
import "package:rubricatres/metodos_firebase/metodos.dart";

class AddBook extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBook> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final Servicios _servicios = Servicios();

  void _addBook() async {
    String title = _titleController.text.trim();
    String author = _authorController.text.trim();
    String genre = _genreController.text.trim();
    String description = _descriptionController.text.trim();

    if (title.isNotEmpty && author.isNotEmpty && genre.isNotEmpty && description.isNotEmpty) {
      await _servicios.Addlibro(title, author, genre, description);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Libro agregado exitosamente')),
      );

      // Clear the text fields after adding the book
      _titleController.clear();
      _authorController.clear();
      _genreController.clear();
      _descriptionController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Libro'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                  Icons.library_add,
                  size: 100,
                  color: Colors.blue,
                ),
                SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _authorController,
                decoration: InputDecoration(
                  labelText: 'Autor',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _genreController,
                decoration: InputDecoration(
                  labelText: 'Género',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _addBook,
                child: Text('Agregar Libro'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shadowColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

