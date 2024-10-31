abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {}

class NewsGetBusinessLoadingState extends AppStates {}

class NewsGetBusinessDataState extends AppStates {}

class NewsGetBusinessErrorState extends AppStates {
  final String error;
  NewsGetBusinessErrorState(this.error);
}

class NewsGetScienceLoadingState extends AppStates {}

class NewsGetScienceDateState extends AppStates {}

class NewGetScienceErrorState extends AppStates {
  final String error;
  NewGetScienceErrorState(this.error);
}

class NewsGetSportLoadingState extends AppStates {}

class NewsGetSportDateState extends AppStates {}

class NewGetSportErrorState extends AppStates {
  final String error;
  NewGetSportErrorState(this.error);
}

class NewsGetSearchLoadingState extends AppStates{}

class NewsGetSearchDataState extends AppStates{}

class NewsGetSearchErrorState extends AppStates{
  final String error;
  NewsGetSearchErrorState(this.error);
}

class ChangeThemeMode extends AppStates {}
