import 'package:e_com/core/ui.dart';
import 'package:e_com/logic/cubit/category_cubit/category_cubit.dart';
import 'package:e_com/logic/cubit/category_cubit/category_state.dart';
import 'package:e_com/presentation/widgets/gap_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

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
            return   Column(
              children: [
                const Card(
                  color: Colors.white70,
                  child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Icon(
                        Icons.category_rounded,
                        size: 50,
                        color: Colors.brown,
                      )),
                ),
                const GapWidget(
                  size: -10,
                ),
                Text(
                  state.categories[index].title.toString(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
