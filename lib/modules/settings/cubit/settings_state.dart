part of 'settings_cubit.dart';

@immutable
abstract class SettingsState {}

class SettingsInitial extends SettingsState {}
class SettingsShowData extends SettingsState {
  UserDataModel userModel;
  SettingsShowData(this.userModel);
}
class SettingsError extends SettingsState {
  String message;
  SettingsError(this.message);
}
class SettingsLoading extends SettingsState {}
