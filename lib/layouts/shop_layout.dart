import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/shop_cubit.dart';
import 'package:shop_app/modules/categories/cubit/categories_cubit.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()),
        BlocProvider(create: (BuildContext context) => CategoriesCubit()..getCategories()),
      ],
      child: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          if(state is ShopSuccessChangeFavoriteState) {
            if(!state.model.status) {
              showToast(text: state.model.message, status: ToastStatus.ERROR);
            }
          }
        },
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('SHOPING'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: (() => navigateTo(context, const SearchScreen())),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.screens.map(
                (screen) {
                  BottomBarItemInfo info = getBottomNavBarDate(screen);
                  return BottomNavigationBarItem(
                      icon: Icon(info.icon), label: info.label);
                },
              ).toList(),
              currentIndex: cubit.currentIndex,
              onTap: (value) {
                cubit.changeBottom(value);
                print(value);
              },
            ),
          );
        },
      ),
    );
  }

  // void
}
