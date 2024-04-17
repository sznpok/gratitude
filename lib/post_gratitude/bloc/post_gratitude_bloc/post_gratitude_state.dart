part of 'post_gratitude_bloc.dart';

@immutable
sealed class PostGratitudeState {}

final class PostGratitudeInitial extends PostGratitudeState {}

final class PostGratitudeSuccessState extends PostGratitudeState {}

final class PostGratitudeErrorState extends PostGratitudeState {}

final class PostGratitudeLoadingState extends PostGratitudeState {}
