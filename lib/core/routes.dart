import 'package:e_com/data/Model/category_model.dart';
import 'package:e_com/data/Model/product_model.dart';
import 'package:e_com/logic/cubit/category_product_cubit/category_product_cubit.dart';
import 'package:e_com/presentation/screens/auth/login_screen.dart';
import 'package:e_com/presentation/screens/auth/provider/login_provider.dart';
import 'package:e_com/presentation/screens/auth/provider/signup_provider.dart';
import 'package:e_com/presentation/screens/auth/signup_screen.dart';
import 'package:e_com/presentation/screens/cart/cart_screen.dart';
import 'package:e_com/presentation/screens/home/category_screen.dart';
import 'package:e_com/presentation/screens/home/home_screen.dart';
import 'package:e_com/presentation/screens/product/category_product_screen.dart';
import 'package:e_com/presentation/screens/product/product_details_screen.dart';
import 'package:e_com/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../presentation/screens/user/edit_profile.dart';

class Routes {
  static CupertinoPageRoute? onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => LoginProvider(context),
            child: const LoginScreen(),
          ),
        );

      case SignupScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SignUpProvider(context),
            child: const SignupScreen(),
          ),
        );

      case HomeScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        );

      case SplashScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case ProductDetailsScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => ProductDetailsScreen(
            productModel: routeSettings.arguments as ProductModel,
          ),
        );

      case CartScreen.routName:
        return CupertinoPageRoute(
          builder: (context) => const CartScreen(),
        );

      case CategoryProductScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CategoryProductCubit(routeSettings.arguments as CategoryModel),
            child: const CategoryProductScreen(),
          ),
        );

      case EditProfileScreen.routeName:
        return CupertinoPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
      default:
        return null;
    }
  }
}
