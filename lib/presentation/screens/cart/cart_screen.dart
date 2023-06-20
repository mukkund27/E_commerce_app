import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_com/core/ui.dart';
import 'package:e_com/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_com/logic/cubit/cart_cubit/cart_state.dart';
import 'package:e_com/logic/services/total_calculation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:input_quantity/input_quantity.dart';

import '../../../logic/services/formater.dart';
import '../../widgets/gap_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const String routName = "cart";

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoadingState && state.items.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is CartErrorState && state.items.isEmpty) {
              return Center(
                child: Text(state.message.toString()),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = state.items[index];
                      return ListTile(
                        leading: CachedNetworkImage(
                          imageUrl: item.product!.images![0],
                        ),
                        title: Text(
                          "${item.product?.title.toString()}",
                          maxLines: 1,
                          style: TextStyles.body1,
                        ),
                        subtitle: Text("${Formatter.formatPrice(item.product!.price!)} X ${item.quantity} = ${Formatter.formatPrice(
                          item.product!.price! * item.quantity!,
                        )}"),
                        trailing: InputQty(
                            onQtyChanged: (value) {
                              BlocProvider.of<CartCubit>(context).addToCart(item.product!, value as int);
                            },
                            minVal: 1,
                            maxVal: 10,
                            initVal: item.quantity!,
                            showMessageLimit: false),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${state.items.length} items",
                              style: TextStyles.body1.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Total: ${Formatter.formatPrice(TotalCalculation.cartTotal(state.items))}",
                              style: TextStyles.heading3,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: w / 2.5,
                        child: CupertinoButton(
                          minSize: 10,
                          padding: EdgeInsets.all(w / 22),
                          color: AppColors.accent,
                          child: Text(
                            "Place Order",
                            style: TextStyles.body2.copyWith(color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
