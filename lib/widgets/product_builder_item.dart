import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_flutter_shop_app/models/home_model.dart';



Widget productItem(HomeModel? model) => Column(
      children: [
        CarouselSlider(
          items: model!.data!.banners
              .map(
                (e) => Image(
                  width: double.infinity,
                  image: NetworkImage("${e.image}"),
                ),
              )
              .toList(),
          options: CarouselOptions(
            height: 200.0,
            autoPlay: true,
            enableInfiniteScroll: true,
            initialPage: 0,
            reverse: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(minutes: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
        )
      ],
    );
