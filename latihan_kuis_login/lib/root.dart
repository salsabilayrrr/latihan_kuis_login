import 'package:flutter/material.dart';

import 'models/food_item.dart';
import 'home.dart';
import 'profile.dart';

class Root extends StatefulWidget {
  // const Root({super.key}); before

  //after
  final String username;
  final String nama;
  // 👈 Menangkap parameter nama dari LoginPage
  const Root({super.key, 
  required this.nama,
  required this.username});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedIndex = 0;
  final List<FoodItem> foodList = FoodItem.sampleData;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(namaUsername: widget.username, foodList: foodList),


    //kalo home pake nama bukan username maka  menjadi 
    // HomePage(
    //   namaUser: widget.nama,
    //   foodList: foodList,
    // ),


      ProfilePage(
        //tambahan
        namaUser: widget.nama,
        username: widget.username,

        onMenuTap: () {
          setState(() {
            _selectedIndex =
                0; // Mengubah tab aktif kembali ke Menu saat kartu diklik
          });
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedIndex == 0 ? 'Menu resto' : 'Profil'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,

        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        currentIndex: _selectedIndex,

        unselectedLabelStyle: const TextStyle(fontSize: 12),
        elevation: 8, // ← Shadow effect

        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
