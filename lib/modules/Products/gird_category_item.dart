import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/category_data_model.dart';

Widget gridCategoryItem(CategoryModel model) {
  return Container(
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children:  [
        Image(
          width: 120,
          height: 120,
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(
              model.image),
        ),
        Container(
          color: Colors.black.withOpacity(0.5),
          width: 120,
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
