import 'package:bobber/screens/add_plunge.dart';
import 'package:bobber/screens/connect.dart';
import 'package:bobber/screens/home_screen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 1;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen();

    var activePageTitle = 'Home';

    if (_selectedPageIndex == 0) {
      activePage = const SplashScreen();
      activePageTitle = 'Connect Bobber';
    }
        if (_selectedPageIndex == 2) {
      activePage = const AddPlunge();
      activePageTitle = 'Add Data Manually';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle),
      ),
body: activePage,
bottomNavigationBar: BottomNavigationBar(
  onTap: _selectPage,
  currentIndex: _selectedPageIndex,
  items: const [
  BottomNavigationBarItem(icon: Icon(Icons.troubleshoot_sharp),label: 'Connect'),
  BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home'),
   BottomNavigationBarItem(icon: Icon(Icons.add),label: 'Add Data'),
],),
    );
  }
}
