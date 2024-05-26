import 'package:e_store/models/change_favs_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopHomeDataLoadingState extends ShopStates {}

class ShopHomeDataSuccessState extends ShopStates {}

class ShopHomeDataErrorState extends ShopStates {}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopCategoriesErrorState extends ShopStates {}

class ShopChangeFavState extends ShopStates {}

class ShopChangeFavSuccessState extends ShopStates {
  ChangeFavsModel model;

  ShopChangeFavSuccessState(this.model);
}

class ShopChangeFavErrorState extends ShopStates {}

class ShopGetFavsSuccessState extends ShopStates {}

class ShopGetFavsErrorState extends ShopStates {}

class ShopGetFavsLoadingState extends ShopStates {}
