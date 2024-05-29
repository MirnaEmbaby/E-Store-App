import 'package:e_store/models/change_favs_model.dart';
import 'package:e_store/models/login_model.dart';

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

class ShopGetUserDataSuccessState extends ShopStates {
  final LoginModel? loginModel;

  ShopGetUserDataSuccessState(this.loginModel);
}

class ShopGetUserDataErrorState extends ShopStates {}

class ShopGetUserDataLoadingState extends ShopStates {}

class ShopUpdateUserDataSuccessState extends ShopStates {
  final LoginModel? loginModel;

  ShopUpdateUserDataSuccessState(this.loginModel);
}

class ShopUpdateUserDataErrorState extends ShopStates {}

class ShopUpdateUserDataLoadingState extends ShopStates {}
