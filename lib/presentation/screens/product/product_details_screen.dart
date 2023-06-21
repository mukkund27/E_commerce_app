import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_com/core/ui.dart';
import 'package:e_com/data/Model/product_model.dart';
import 'package:e_com/logic/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_com/logic/cubit/cart_cubit/cart_state.dart';
import 'package:e_com/logic/services/formater.dart';
import 'package:e_com/presentation/widgets/gap_widget.dart';
import 'package:e_com/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;

  const ProductDetailsScreen({Key? key, required this.productModel}) : super(key: key);
  static const String routeName = "product_details";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.productModel.title}"),
      ),
      body: SafeArea(
        child: ListView(shrinkWrap: true,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: CarouselSlider.builder(
                itemCount: widget.productModel.images?.length ?? 0,
                slideBuilder: (int index) {
                  String url = widget.productModel.images![index];
                  return CachedNetworkImage(
                    imageUrl: url,
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
            const GapWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.productModel.title}",
                    style: TextStyles.heading3,
                  ),
                  Text(
                    Formatter.formatPrice(widget.productModel.price!),
                    style: TextStyles.heading2,
                  ),
                  const GapWidget(
                    size: 10,
                  ),
                  BlocBuilder<CartCubit,CartState>(
                    builder: (context, state) {
                      bool isInCart=(BlocProvider.of<CartCubit>(context).cartContains(widget.productModel));
                      return  PrimaryButton(
                        color: (isInCart)? AppColors.textLight : AppColors.accent,
                        text: (isInCart) ? "Product Added to Cart" : "Add to cart",
                        onPressed: () {
                          if (isInCart) {
                            return;
                          }
                          BlocProvider.of<CartCubit>(context).addToCart(widget.productModel, 1);
                        },
                      );
                    },
                  ),
                  const GapWidget(
                    size: 10,
                  ),
                  Text(
                    "Description",
                    style: TextStyles.body2.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.productModel.description}",
                    style: TextStyles.body1,
                  ),
                  const GapWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
