import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_com/logic/cubit/product_cubit/product_cubit.dart';
import 'package:e_com/logic/cubit/product_cubit/product_state.dart';
import 'package:e_com/logic/services/formater.dart';
import 'package:e_com/presentation/screens/product/product_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/ui.dart';
import '../../widgets/gap_widget.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({Key? key}) : super(key: key);

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState && state.products.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProductErrorState && state.products.isEmpty) {
          return Center(
            child: Text(state.message.toString()),
          );
        }

        return ListView.builder(
          itemCount: state.products.length,
          itemBuilder: (BuildContext context, int index) {
            final product = state.products[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
              child: CupertinoButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProductDetailsScreen.routeName, arguments: product);
                },
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    CachedNetworkImage(
                      width: MediaQuery.of(context).size.width / 4.5,
                      imageUrl: "${product.images?[0]}",
                      fit: BoxFit.fill,
                      height: 100,
                    ),
                    const GapWidget(),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            product.description.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.body2.copyWith(color: AppColors.textLight),
                          ),
                          const GapWidget(
                            size: -10,
                          ),
                          Text(
                            Formatter.formatPrice(product.price!),
                            style: TextStyles.body1.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    IconButton(padding: EdgeInsets.zero, onPressed: () {}, icon: const Icon(CupertinoIcons.cart)),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
