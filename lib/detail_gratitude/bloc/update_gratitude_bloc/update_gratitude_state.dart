part of 'update_gratitude_bloc.dart';

@immutable
sealed class UpdateGratitudeState {}

final class UpdateGratitudeInitial extends UpdateGratitudeState {}

final class UpdateGratitudeErrorState extends UpdateGratitudeState {}

final class UpdateGratitudeLoadingState extends UpdateGratitudeState {}

final class UpdateGratitudeSuccessState extends UpdateGratitudeState {}
