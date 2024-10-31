import 'package:first_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/bussines_screen/BussinesScreen.dart';
import '../../modules/science_screen/ScienceScreen.dart';
import '../../modules/sport_screen/SportScreen.dart';
import '../../network/local/CashHelper.dart';
import '../../network/remote/DioHelper.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> bottomItem = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_sharp), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sport')
  ];

  int currentIndex = 0;
  List<Widget> screens = [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportScreen()
  ];

  void indexChange(int index) {
    if (index == 1) {
      getscience();
    } else if (index == 2) {
      getSport();
    }
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<dynamic> business = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getdate(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': '72f978b0663643adbb9755f3e79f641f'
    }).then((value) {
      business = value.data['articles'];
      print('############################333');
      print(business[0]['title']);
      emit(NewsGetBusinessDataState());
    }).catchError((error) {
      print('the error type: ${error.toString()}');
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> science = [];

  void getscience() {
    emit(NewsGetScienceLoadingState());

    DioHelper.getdate(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'science',
      'apiKey': '72f978b0663643adbb9755f3e79f641f'
    }).then((value) {
      science = value.data['articles'];
      print(science[0]['title']);
      emit(NewsGetScienceDateState());
    }).catchError((error) {
      print(
          'error when get Science data : the error type : ${error.toString()}');
      emit(NewGetScienceErrorState(error.toString()));
    });
  }

  List<dynamic> sport = [];

  void getSport() {
    emit(NewsGetSportLoadingState());
    DioHelper.getdate(url: 'v2/top-headlines', query: {
      'country': 'us',
      'category': 'sport',
      'apiKey': '72f978b0663643adbb9755f3e79f641f'
    }).then((value) {
      sport = value.data['articles'];
      print(sport[0]['title']);
      emit(NewsGetSportDateState());
    }).catchError((error) {
      print('error when get Sport data : the error type : ${error.toString()}');
      emit(NewGetSportErrorState(error.toString()));
    });
  }

  List<dynamic> search = [];
  void getSearch({required query}) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getdate(url: 'v2/everything', query: {
      'q': '$query',
      'apiKey': '72f978b0663643adbb9755f3e79f641f'
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchDataState());
    }).catchError((error) {
      print('error when get search data : the error type :${error.toString()}');
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  bool isDark = true;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeThemeMode());
    } else {
      isDark = !isDark;
      CashHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeMode());
      });
    }
  }
}
