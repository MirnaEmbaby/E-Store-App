import 'package:e_store/models/categories_model.dart';
import 'package:e_store/models/change_favs_model.dart';
import 'package:e_store/models/favourites_model.dart';
import 'package:e_store/models/home_model.dart';
import 'package:e_store/models/login_model.dart';
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
    SettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favourites = {};

  void getHomeData() {
    emit(ShopHomeDataLoadingState());

    DioHelper.getData(
      url: home,
      token: token,
    ).then(
      (value) {
        homeModel = HomeModel.fromJson(value.data);

        for (var element in homeModel!.data.products) {
          favourites.addAll(
            {element.id: element.inFavourites},
          );
        }

        debugPrint(favourites.toString());

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

  ChangeFavsModel? changeFavsModel;

  void changeFavs(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavState());

    DioHelper.postData(
      url: favorites,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavsModel = ChangeFavsModel.fromJson(value.data);
      debugPrint(value.data.toString());

      if (!changeFavsModel!.status!) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavorites();
      }

      debugPrint(changeFavsModel!.message);
      emit(ShopChangeFavSuccessState(changeFavsModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      favourites[productId] = !favourites[productId]!;
      emit(ShopChangeFavErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopGetFavsLoadingState());

    DioHelper.getData(
      url: favorites,
      token: token,
    ).then(
      (value) {
        favoritesModel = FavoritesModel.fromJson(value.data);
        printFullText(value.data.toString());
        emit(ShopGetFavsSuccessState());
      },
    ).catchError(
      (error) {
        debugPrint(error.toString());
        emit(ShopGetFavsErrorState());
      },
    );
  }

  LoginModel? userModel;

  void getUserData() {
    emit(ShopGetUserDataLoadingState());

    DioHelper.getData(
      url: profile,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name);

      emit(ShopGetUserDataSuccessState(userModel));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopGetUserDataErrorState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateUserDataLoadingState());

    DioHelper.putData(
      url: updateProfile,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      printFullText(userModel!.data!.name);

      emit(ShopGetUserDataSuccessState(userModel));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopGetUserDataErrorState());
    });
  }
}
