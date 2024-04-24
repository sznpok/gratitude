part of 'list_gratitude_bloc.dart';

@immutable
sealed class ListGratitudeState extends Equatable {}

final class ListGratitudeInitial extends ListGratitudeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ListGratitudeSuccessState extends ListGratitudeState {
  final ListGratitudeModel? listGratitudeModel;

  ListGratitudeSuccessState(
    this.listGratitudeModel,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
        listGratitudeModel,
      ];
}

final class ListGratitudeErrorState extends ListGratitudeState {
  final String error;

  ListGratitudeErrorState(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ListGratitudeLoadingState extends ListGratitudeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
