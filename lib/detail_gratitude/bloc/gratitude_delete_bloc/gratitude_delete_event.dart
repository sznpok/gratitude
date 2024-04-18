part of 'gratitude_delete_bloc.dart';

@immutable
sealed class GratitudeDeleteEvent extends Equatable {}

class OnDeleteGratitudeDeleteEvent extends GratitudeDeleteEvent {
  final String id;

  OnDeleteGratitudeDeleteEvent(this.id);

  @override
  // TODO: implement props
  List<Object?> get props => [id];
}
