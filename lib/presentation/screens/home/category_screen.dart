import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_com/core/ui.dart';
import 'package:e_com/logic/cubit/category_cubit/category_cubit.dart';
import 'package:e_com/logic/cubit/category_cubit/category_state.dart';
import 'package:e_com/presentation/screens/product/category_product_screen.dart';
import 'package:e_com/presentation/widgets/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}


List<String> imageUrl = [
  "https://static-assets.business.amazon.com/assets/in/24th-jan/705_Website_Blog_Appliances_1450x664.jpg.transform/1450x664/image.jpg",
  "https://images.unsplash.com/photo-1555529771-835f59fc5efe?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80",
  "https://images.unsplash.com/photo-1483985988355-763728e1935b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZmFzaGlvbnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80"
];

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadingState && state.categories.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CategoryErrorState && state.categories.isEmpty) {
          return Center(
            child: Text(state.message.toString()),
          );
        }

        return GridView.builder(
          itemCount: state.categories.length,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 180,
            mainAxisSpacing: 10,
            crossAxisSpacing: 0,
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            final category = state.categories[index];
            return Column(
              children: [
                GestureDetector(onTap: () {
                  Navigator.pushNamed(context, CategoryProductScreen.routeName, arguments: category);
                },
                  child:   Card(
                    color: Colors.white70,
                    child: SizedBox(
                        height: 150,
                        width: 150,
                        child: CachedNetworkImage(imageUrl:imageUrl[index].toString(),fit: BoxFit.cover,)),
                  ),
                ),
                const GapWidget(
                  size: -10,
                ),
                Text(
                  category.title.toString(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
