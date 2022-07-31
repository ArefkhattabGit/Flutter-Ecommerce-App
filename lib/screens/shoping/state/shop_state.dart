abstract class ShopState {}

class ShopInitialState extends ShopState {}

class ShopChangeBottomNaviationBarState extends ShopState {}

class ShopLoadinDataState extends ShopState {}

class ShopLoadingDataSuccessState extends ShopState {}

class ShopLoadingDataErrorState extends ShopState {
  final String error;

  ShopLoadingDataErrorState(this.error);
}

class ShopLoadingCategoriesSuccessState extends ShopState {}

class ShopLoadingCategoriesErrorState extends ShopState {
  final String error;

  ShopLoadingCategoriesErrorState(this.error);
}

class ShopSuccessChangeFavoritesState extends ShopState {}

class ShopErrorChangeFavoritesState extends ShopState {
  final String error;

  ShopErrorChangeFavoritesState(this.error);
}

class ShopProfileLoadingState extends ShopState {}

class ShopProfileSuccessState extends ShopState {}

class ShopProfileErrorState extends ShopState {
  final String error;

  ShopProfileErrorState(this.error);
}
