part of 'gratitude_delete_bloc.dart';

@immutable
sealed class GratitudeDeleteState {}

final class GratitudeDeleteInitial extends GratitudeDeleteState {}

final class GratitudeDeleteSuccessState extends GratitudeDeleteState {}

final class GratitudeDeleteErrorState extends GratitudeDeleteState {}

final class GratitudeDeleteLoadingState extends GratitudeDeleteState {}
