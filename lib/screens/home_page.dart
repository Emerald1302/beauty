import 'package:final_pj/tabs/cart_tab.dart';
import 'package:final_pj/tabs/home_tab.dart';
import 'package:final_pj/tabs/profile_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  dynamic userDetails;
  HomePage({super.key, required this.userDetails});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> item) {
    setState(() {

      cart.add(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item['name']} is added to cart'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Emerald Beauty Bar (6610339)",
                    style: TextStyle(
                      color: Colors.white,
                    )),
                bottom: const TabBar(tabs: [
                  Tab(
                    icon: Icon(
                      Icons.auto_fix_high,
                      color: Colors.white,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  )
                ]),
              ),
              body: TabBarView(children: [
                HomeTab(
                  addToCart: addToCart,
                ),
                CartTab(
                  cartList: cart,
                ),
                ProfileTab(userDetails: widget.userDetails)
              ]),
            )));
  }
}
