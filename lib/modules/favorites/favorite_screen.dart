import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/shop_cubit.dart';
import 'package:shop_app/models/favorite_home_product_response.dart';
import 'package:shop_app/modules/favorites/cubit/favorit_cubit.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/themes.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritCubit()..getFavorites(),
      child: BlocConsumer<FavoritCubit, FavoritState>(
        listener: (context, state) {
          if (state is FavoritErrorState) {
            showToast(text: state.message, status: ToastStatus.ERROR);
          }
        },
        builder: (context, state) {
          FavoritCubit cubit = FavoritCubit.get(context);
          switch (state.runtimeType) {
            case FavoritSuccessState:
              return buildSuccessState(cubit);
            case FavoritLoadingState:
              return buildLoadingState();
            case FavoritErrorState:
              return buildErrorState('Error');
            case FavoritEmptyState:
              return buildEmptyState();
            default:
              return Container();
          }
        },
      ),
    );
  }

  Widget buildSuccessState(FavoritCubit cubit) {
    return ListView.separated(
      itemBuilder: (context, index) {
        var product = cubit.myFavorite[index].product;
        return Container(
          height: 140,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image(
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(product?.image ?? ''),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product?.name ?? 'Product name',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const Spacer(flex: 2,),
                      Row(
                        children: [
                          Text('${product?.price ?? 0.0}'),
                          const Spacer(),
                          CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Themes.primaryColor ,
                        child: IconButton(
                          iconSize: 18.0,
                          color: Colors.white,
                          icon: const Icon(Icons.favorite_border_outlined),
                          onPressed: (() {
                            print('Love ${product?.id}');
                            cubit.deleteFromFav(ShopCubit.get(context), product?.id.toInt() ?? 0);
                          }),
                        ),
                      ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
      itemCount: cubit.myFavorite.length,
    );
  }

  Widget buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget buildEmptyState() {
    return const Center(child: Text('Empty'));
  }

  Widget buildErrorState(String message) {
    return Center(child: Text(message));
  }
}
