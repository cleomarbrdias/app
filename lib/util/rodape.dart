import 'package:conass/paginas/home_page.dart';
import 'package:conass/util/push.dart';
import 'package:flutter/material.dart';

class Rodape extends StatefulWidget {
  @override
  _RodapeState createState() => _RodapeState();
}

class _RodapeState extends State<Rodape> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      pushReplacement(context, HomePage());
    } else if (index == 1) {
      print(index);
      print("Print Pesquisa");
    } else if (index == 2) {
      print(index);
      print("Printe avorito");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.home_outlined),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.search),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.bookmark_outline_outlined),
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
