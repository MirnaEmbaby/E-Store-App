import 'package:e_store/models/categories_model.dart';
import 'package:e_store/models/home_model.dart';
import 'package:e_store/modules/categories/categories_screen.dart';
import 'package:e_store/modules/favourites/favourites_screen.dart';
import 'package:e_store/modules/products/products_screen.dart';
import 'package:e_store/modules/settings/settings_screen.dart';
import 'package:e_store/modules/shop_layout/cubit/states.dart';
import 'package:e_store/shared/components/components.dart';
import 'package:e_store/shared/components/constants.dart';
import 'package:e_store/shared/network/end_points.dart';
import 'package:e_store/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    const SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopHomeDataLoadingState());

    DioHelper.getData(
      url: home,
      token: token,
    ).then(
      (value) {
        homeModel = HomeModel.fromJson(value.data);
        emit(ShopHomeDataSuccessState());
        printFullText(homeModel!.data.banners[0].image);
      },
    ).catchError(
      (error) {
        debugPrint(error.toString());
        emit(ShopHomeDataErrorState());
      },
    );
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: get_categories,
      token: token,
    ).then(
      (value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        emit(ShopCategoriesSuccessState());
      },
    ).catchError(
      (error) {
        debugPrint(error.toString());
        emit(ShopCategoriesErrorState());
      },
    );
  }
}
