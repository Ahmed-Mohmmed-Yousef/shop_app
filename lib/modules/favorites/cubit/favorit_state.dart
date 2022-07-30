part of 'favorit_cubit.dart';

@immutable
abstract class FavoritState {}

class FavoritInitialState extends FavoritState {}
class FavoritLoadingState extends FavoritState {}
class FavoritSuccessState extends FavoritState {}
class FavoritEmptyState extends FavoritState {}
class FavoritErrorState extends FavoritState {
  final String message;
  FavoritErrorState(this.message);
}
