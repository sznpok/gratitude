part of 'post_gratitude_bloc.dart';

@immutable
sealed class PostGratitudeEvent extends Equatable {}

class OnPostGratitudeEvent extends PostGratitudeEvent {
  final String title;
  final String profile;

  OnPostGratitudeEvent(this.title, this.profile);

  @override
  // TODO: implement props
  List<Object?> get props => [title, profile];
}
