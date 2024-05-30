import 'package:e_store/models/search_model.dart';
import 'package:e_store/modules/search/cubit/states.dart';
import 'package:e_store/shared/components/constants.dart';
import 'package:e_store/shared/network/end_points.dart';
import 'package:e_store/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: searchPoint,
      data: {'text': text},
      token: token,
    ).then(
      (value) {
        model = SearchModel.fromJson(value.data);
        emit(SearchSuccessState());
      },
    ).catchError(
      (error) {
        emit(SearchErrorState());
      },
    );
  }
}
