import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_store/models/favourites_model.dart';
import 'package:e_store/modules/shop_layout/cubit/cubit.dart';
import 'package:e_store/modules/shop_layout/cubit/states.dart';
import 'package:e_store/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        FavoritesModel? model = ShopCubit.get(context).favoritesModel;
        return ConditionalBuilder(
          condition: state is! ShopGetFavsLoadingState,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
              itemBuilder: (context, index) =>
                  buildListItem(model.data.data[index].product, context),
              separatorBuilder: (context, index) => const SizedBox(
                height: 10.0,
              ),
              itemCount: model!.data.data.length,
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
