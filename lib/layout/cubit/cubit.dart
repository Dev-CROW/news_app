import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/cubit/states.dart';
import 'package:news_app/modules/business_screen.dart';
import 'package:news_app/modules/science_screen.dart';
import 'package:news_app/modules/sports_screen.dart';
import 'package:news_app/shared/network/local/cache/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(InitialState());

  static NewsCubit get(context) => BlocProvider.of(context);
  List<BottomNavigationBarItem> bottombaritems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  int currentIndex = 0;

  void changeNavBarIndex(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(BottomNavBarChangeIndexState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        business = value.data['articles'];
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print("error while getBusiness Data $error");
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else
      emit(NewsGetBusinessSuccessState());
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print("error while getSports Data $error");
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else
      emit(NewsGetSportsSuccessState());
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print("error while getScience Data $error");
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else
      emit(NewsGetScienceSuccessState());
  }

  List<dynamic> search = [];

  void getSearch(value) {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print("error while getSearch Data $error");
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

  IconData fabIcon = Icons.edit;
  bool isBottomSheetShown = false;

  void changeBottomSheetState({
    @required bool isShow,
    @required IconData icon,
  }) {
    isBottomSheetShown = isShow;
    fabIcon = icon;

    emit(AppChangeBottomSheetState());
  }

  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}
