import 'package:flutter/material.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key, required this.cartList});
  final List<Map<String, dynamic>> cartList;

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  double showToal() {
    double total = 0;
    if (widget.cartList.isEmpty) {
      return 0;
    }

    for (int i = 0; i < widget.cartList.length; i++) {
      total += widget.cartList[i]['price'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.cartList.isEmpty
          ? const Center(
              child: Text('Cart is empty'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.cartList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                  height: 100,
                                  width: 100,
                                  image: NetworkImage(
                                      widget.cartList[index]['avatar'])),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.cartList[index]['name']),
                                  Text(
                                      "\$ ${widget.cartList[index]['price'].toStringAsFixed(2)}")
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.cartList.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.remove_shopping_cart))
                            ],
                          ),
                        );
                      }),
                ),
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Checkout: ${showToal()}",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
    );
  }
}
