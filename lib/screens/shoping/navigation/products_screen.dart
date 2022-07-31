import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_shop_app/conestance/const.dart';
import 'package:new_flutter_shop_app/models/categories_model.dart';
import 'package:new_flutter_shop_app/models/home_model.dart';

import 'package:new_flutter_shop_app/screens/shoping/cubit/shop_cubit.dart';
import 'package:new_flutter_shop_app/screens/shoping/state/shop_state.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  productBuilder(ShopCubit.get(context).homeModel,
                      ShopCubit.get(context).categoriesModel, context),
                ],
              ),
            );
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget productBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model!.data!.banners
                  .map(
                    (e) => Image(
                      height: 180.0,
                      image: NetworkImage(e.image.toString()),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayInterval: const Duration(seconds: 3),
                autoPlay: true,
                initialPage: 0,
                enableInfiniteScroll: true,
                viewportFraction: 1.0,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                  SizedBox(
                    height: 100.0,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildCategory(categoriesModel!.data!.data![index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 10.0,
                      ),
                      itemCount: categoriesModel!.data!.data!.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    'New Products',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.40,
                crossAxisCount: 2,
                children: List.generate(model.data!.products.length, (index) {
                  return GridProduct(model.data!.products[index], context);
                }),
              ),
            ),
          ],
        ),
      );

  // List.generate(model.data!.products.length,
  // (index) => GridProduct(model.data!.products[index]))
  Widget GridProduct(ProductModel? productModel, context) => Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    height: 200.0,
                    width: double.infinity,
                    image: NetworkImage(
                      productModel!.image.toString(),
                    ),
                  ),
                  if (productModel.discount != 0)
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(2.0)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 5.0),
                        child: Text(
                          'DISCOUNT',
                          style: buildCustomTextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
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
                      productModel.name.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          height: 1.1,
                          color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          productModel.price.toString(),
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue),
                        ),
                        const Spacer(),
                        if (productModel.discount != 0)
                          Text(
                            productModel.oldPrice.toString(),
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.red),
                          ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubit.get(context)
                                      .favorite[productModel.id] ==
                                  true
                              ? Colors.red
                              : Colors.grey,
                          child: IconButton(
                              iconSize: 18.0,
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                ShopCubit.get(context)
                                    .ChangeFavorites(productModel.id);
                                print(productModel.id);
                              },
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                              )),
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

  Widget buildCategory(DataModel? dataModel) => SizedBox(
        width: 100.0,
        height: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Card(
              elevation: 2.0,
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Image.network(
                  dataModel!.image.toString(),
                  height: 100,
                ),
              ),
            ),
            Container(
              child: Text(
                dataModel.name.toString(),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              color: Colors.black54,
              width: double.infinity,
            )
          ],
        ),
      );
}
