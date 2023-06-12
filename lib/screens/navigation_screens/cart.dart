// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers


import 'package:clothing/screens/navigation_screens/profil.dart';
import 'package:clothing/screens/navigation_screens/search.dart';
import 'package:clothing/screens/welcome_screen/welcome.dart';
import 'package:clothing/widgets/cart_details.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}



class _CartState extends State<Cart> {
  int pageIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;

      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Welcome()));
      }
      if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Search()));
      }
      if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Cart()));
      }
      if (index == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Profil()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(
        child: cartData("Cart"),
      ),
      bottomNavigationBar: GNav(
        selectedIndex: pageIndex,
        color: Colors.grey,
        activeColor: Color.fromRGBO(177, 63, 181, 1),
        gap: 8,
        tabs: [
          GButton(
              icon: Icons.home,
              text: 'Home',
              onPressed: () {
                _onItemTapped(0);
              }),
          GButton(
              icon: Icons.search,
              text: 'Search',
              onPressed: () {
                _onItemTapped(1);
              }),
          GButton(
            icon: Icons.shopping_cart,
            text: 'Cart',
            onPressed: () {
              _onItemTapped(2);
            },
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
            onPressed: () {
              _onItemTapped(3);
            },
          ),
        ],
      ),
    );
  }
}
