part of 'list_gratitude_bloc.dart';

@immutable
sealed class ListGratitudeEvent {}

class LoadingListGratitudeEvent extends ListGratitudeEvent {}