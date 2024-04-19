part of 'update_gratitude_bloc.dart';

@immutable
sealed class UpdateGratitudeEvent extends Equatable {}

class OnUpdateGratitudeEvent extends UpdateGratitudeEvent {
  final String id;
  final String? title;
  final String? image;

  OnUpdateGratitudeEvent(this.id, this.title, this.image);

  @override
  // TODO: implement props
  List<Object?> get props => [id, title, image];
}
