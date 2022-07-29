import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/shop_cubit.dart';
import 'package:shop_app/models/home_data_model.dart';
import 'package:shop_app/modules/Products/cubit/products_cubit.dart';
import 'package:shop_app/shared/styles/themes.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {
        print('$state ---0-0-0-0-0-0-');
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        var model = cubit.responseModel;

        return ConditionalBuilder(
          condition: model != null,
          builder: (context) => productsBuilder(model!.data!),
          fallback: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  Widget productsBuilder(HomeData model) {
    final List<Product> products = model.products;
    return SingleChildScrollView(
      child: Column(
        children: [
          CarouselSlider(
            items: model.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e.image),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 200,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.67,
              children: model.products
                  .map((product) => buildGridProduct(product))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridProduct(Product product) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(product.image),
                width: double.infinity,
                // fit: BoxFit.fitHeight,
                height: 200,
              ),
              if (product.oldPrice != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.4,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "\$${product.price.round().toString()}",
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Themes.primaryColor,
                      ),
                    ),
                    const SizedBox(width: 40),
                    if (product.oldPrice != 0)
                      Text(
                        "\$${product.oldPrice.round().toString()}",
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.favorite_border_outlined),
                      onPressed: (() {
                        print('Love ${product.name}');
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
