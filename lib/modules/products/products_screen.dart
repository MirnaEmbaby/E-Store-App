import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_store/models/categories_model.dart';
import 'package:e_store/models/home_model.dart';
import 'package:e_store/modules/shop_layout/cubit/cubit.dart';
import 'package:e_store/modules/shop_layout/cubit/states.dart';
import 'package:e_store/shared/components/components.dart';
import 'package:e_store/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavSuccessState) {
          if (!state.model.status!) {
            showToast(state.model.message, ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null &&
              ShopCubit.get(context).categoriesModel != null,
          builder: (context) {
            return builderWidget(ShopCubit.get(context).homeModel!,
                ShopCubit.get(context).categoriesModel!, context);
          },
          fallback: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      },
    );
  }
}

Widget builderWidget(
        HomeModel model, CategoriesModel categoriesModel, context) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 130.0,
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    buildCategoryItem(categoriesModel.data.data[index]),
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 10.0),
                itemCount: categoriesModel.data.data.length,
              ),
            ),
            CarouselSlider(
              items: model.data.banners
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayInterval: const Duration(seconds: 3),
                enableInfiniteScroll: true,
                height: 250.0,
                initialPage: 0,
                reverse: false,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            const Text(
              'For You',
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            buildProductsGrid(model, context),
          ],
        ),
      ),
    );

Widget buildProductsGrid(model, context) => GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 1 / 1.58,
      crossAxisSpacing: 4.0,
      mainAxisSpacing: 4.0,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        model.data.products.length,
        (index) => buildGridItem(model.data.products[index], context),
      ),
    );

Widget buildGridItem(ProductModel model, context) => Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                      model.image!,
                    ),
                    width: double.infinity,
                    height: 150.0,
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(5.0),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                height: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()} EGP',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                          height: 0.1,
                        ),
                      ),
                    Row(
                      children: [
                        Text(
                          '${model.price.round()} EGP',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: defaultTeal,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavs(model.id);
                          },
                          icon: Icon(
                            ShopCubit.get(context).favourites[model.id]!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 18.0,
                            color: defaultTeal,
                            shadows: const [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 10,
                                blurRadius: 10,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

Widget buildCategoryItem(DataModel model) => SizedBox(
      width: 90.0,
      child: Column(
        children: [
          const SizedBox(
            height: 5.0,
          ),
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
            height: 10.0,
          ),
          Text(
            model.name!,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(color: Colors.black, height: 1.0),
          ),
        ],
      ),
    );
