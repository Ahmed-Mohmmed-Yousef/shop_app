part of 'shop_cubit.dart';

@immutable
abstract class ShopState {}

class ShopInitial extends ShopState {}

class ShopChangeBottomNavState extends ShopState {}
class ShopLoadingState extends ShopState {}
class ShopSuccessState extends ShopState {}
class ShopErrorState extends ShopState {
  final String error;

  ShopErrorState(this.error);
}