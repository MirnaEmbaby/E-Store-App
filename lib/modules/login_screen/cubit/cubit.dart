import 'package:e_store/modules/login_screen/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<LoginStates> {
  ShopLoginCubit() : super(LoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin(){

  }

}
