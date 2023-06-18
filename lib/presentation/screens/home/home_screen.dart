import 'package:e_com/presentation/screens/home/category_screen.dart';
import 'package:e_com/presentation/screens/home/profile_screen.dart';
import 'package:e_com/presentation/screens/home/user_feed_screen.dart';
import 'package:e_com/presentation/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int currentIndex=0;

  List<Widget> screens=[
    const UserFeedScreen(),
    const CategoryScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "E-Commerce",
          style: TextStyle(color: Colors.black),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.cart_fill))],
        elevation: 0,
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex=index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: screens[currentIndex]
    );
  }
}
