import 'package:e_com/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_com/logic/cubit/cart_cubit/cart_state.dart';
import 'package:e_com/logic/cubit/user_cubit/user_cubit.dart';
import 'package:e_com/logic/cubit/user_cubit/user_state.dart';
import 'package:e_com/presentation/screens/cart/cart_screen.dart';
import 'package:e_com/presentation/screens/home/category_screen.dart';
import 'package:e_com/presentation/screens/home/profile_screen.dart';
import 'package:e_com/presentation/screens/home/user_feed_screen.dart';
import 'package:e_com/presentation/screens/splash/splash_screen.dart';
import 'package:e_com/presentation/widgets/primary_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<Widget> screens = [
    const UserFeedScreen(),
    const CategoryScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit,UserState>(
      listener: (BuildContext context, state) {
        if(state is UserLoggedOutState){
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              "E-Commerce",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.routName);
                },
                icon: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return Badge(isLabelVisible: (state is CartLoadingState) ? false : true, label: Text("${state.items.length}"), child: const Icon(CupertinoIcons.cart_fill));
                  },
                ),
              )
            ],
            elevation: 0,
            centerTitle: true,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.category), label: "Categories"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
          body: screens[currentIndex]),
    );
  }
}
