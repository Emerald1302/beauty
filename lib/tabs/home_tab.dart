import 'dart:convert';

import 'package:final_pj/screens/add_item_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeTab extends StatefulWidget {
  const HomeTab({super.key, required this.addToCart});

  final Function(Map<String, dynamic>) addToCart;

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<dynamic>? beautyProducts;

  @override
  void initState() {
    super.initState();
    _getData();
  }

//get data from api
  Future<void> _getData() async {
    final getURL = Uri.parse("https://beauty-backend-sooty.vercel.app/beauty/");
    try {
      final response = await http.get(getURL);
      final jsonRes = jsonDecode(response.body);

      setState(() {
        beautyProducts = jsonRes;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddItemPage();
            }));
          }),
      body: Container(
        child: beautyProducts == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: beautyProducts!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                            height: 120,
                            width: 120,
                            image:
                                NetworkImage(beautyProducts?[index]['avatar'])),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(beautyProducts![index]['name']),
                            Text(
                                "\$ ${beautyProducts![index]['price'].toStringAsFixed(2)}")
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              widget.addToCart(beautyProducts![index]);
                            },
                            icon: const Icon(Icons.add_shopping_cart))
                      ],
                    ),
                  );
                }),
      ),
    );
  }
}
