import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AddItemPage extends StatelessWidget {
  AddItemPage({super.key});

  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();
  final _priceController = TextEditingController();
  final _avatarController = TextEditingController();

  final dataURL = "https://beauty-backend-sooty.vercel.app/";

  Future<void> _createData(
      String name, String category, double price, String url) async {
    final headers = {"Content-Type": "application/json"};
    final postURL = Uri.parse("$dataURL/beauty/add");
    final body = jsonEncode(
        {"name": name, "category": category, "price": price, "avatar": url});
    try {
      final response = await http.post(postURL, headers: headers, body: body);
      final jsonRes = jsonDecode(response.body);
      print(jsonRes);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Add Item Into Database',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Name'),
                  ),
                  TextFormField(
                    controller: _categoryController,
                    decoration: const InputDecoration(hintText: 'Category'),
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(hintText: 'Price'),
                  ),
                  TextFormField(
                    controller: _avatarController,
                    decoration: const InputDecoration(hintText: 'Avatar URL'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await _createData(
                            _nameController.text,
                            _categoryController.text,
                            double.parse(_priceController.text),
                            _avatarController.text);

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Item is added to database'),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ));
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'ADD',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
