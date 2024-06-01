import 'package:e_store/models/categories_model.dart';
import 'package:e_store/modules/shop_layout/cubit/cubit.dart';
import 'package:e_store/modules/shop_layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
            itemBuilder: (context, index) => buildCatItem(
                ShopCubit.get(context).categoriesModel!.data.data[index]),
            separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
            ),
            itemCount: ShopCubit.get(context).categoriesModel!.data.data.length,
          ),
        );
      },
    );
  }
}

Widget buildCatItem(DataModel model) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image(
              image: NetworkImage(model.image!),
              height: 80.0,
              width: 80.0,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Text(
          model.name!,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );
}
