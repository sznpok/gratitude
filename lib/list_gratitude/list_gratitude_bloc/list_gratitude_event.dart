part of 'list_gratitude_bloc.dart';

@immutable
sealed class ListGratitudeEvent extends Equatable {}

class LoadingListGratitudeEvent extends ListGratitudeEvent {
  LoadingListGratitudeEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
