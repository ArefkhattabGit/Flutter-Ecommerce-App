import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_flutter_shop_app/models/categories_model.dart';
import 'package:new_flutter_shop_app/models/home_model.dart';
import 'package:new_flutter_shop_app/screens/shoping/cubit/shop_cubit.dart';
import 'package:new_flutter_shop_app/screens/shoping/state/shop_state.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
        builder: (context, state) => ListView.separated(
            itemBuilder: (context, index) => buildcategoryItem(
                ShopCubit.get(context).categoriesModel!.data!.data![index]),
            separatorBuilder: (context, index) => Divider(),
            itemCount:
                ShopCubit.get(context).categoriesModel!.data!.data!.length),
        listener: (context, state) {});
  }
}

Widget buildcategoryItem(DataModel? dataModel) => Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Image(
              width: 80.0,
              height: 80.0,
              image: NetworkImage('${dataModel!.image}')),
          SizedBox(
            width: 20.0,
          ),
          Text(
            '${dataModel.name}',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18.0),
          ),
          Spacer(),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.arrow_forward_ios_outlined)),
        ],
      ),
    );
