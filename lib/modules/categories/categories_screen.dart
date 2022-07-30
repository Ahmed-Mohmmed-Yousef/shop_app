import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_data_model.dart';
import 'package:shop_app/modules/categories/cubit/categories_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoriesCubit cubit = CategoriesCubit.get(context);
    cubit.getCategories();
    return BlocConsumer<CategoriesCubit, CategoriesState>(
      listener: (context, state) {},
      builder: (context, state) {
        CategoriesCubit cubit = CategoriesCubit.get(context);
        return ConditionalBuilder(
          builder: (BuildContext context) =>
              buildGategoryList(cubit.model!.data),
          condition: state is! CategoriesLoadingState,
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildGategoryList(CategoryPageModel pageModel) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
          itemBuilder: ((context, index) =>
              buildeCategoryItem(pageModel.data[index])),
          separatorBuilder: ((context, index) => Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              )),
          itemCount: pageModel.data.length),
    );
  }

  Widget buildeCategoryItem(CategoryModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            height: 100,
            width: 100,
            image: CachedNetworkImageProvider(model.image),
          ),
          Text(
            model.name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              print(model.name);
            },
          ),
        ],
      ),
    );
  }
}
