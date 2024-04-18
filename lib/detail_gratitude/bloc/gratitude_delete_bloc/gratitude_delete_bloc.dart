import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gratitude_app/detail_gratitude/repo/gratitude_delete_repo.dart';
import 'package:meta/meta.dart';

part 'gratitude_delete_event.dart';

part 'gratitude_delete_state.dart';

class GratitudeDeleteBloc
    extends Bloc<GratitudeDeleteEvent, GratitudeDeleteState> {
  GratitudeDeleteBloc() : super(GratitudeDeleteInitial()) {
    on<OnDeleteGratitudeDeleteEvent>(onDeleteGratitudeDeleteEvent);
  }

  FutureOr<void> onDeleteGratitudeDeleteEvent(
      OnDeleteGratitudeDeleteEvent event,
      Emitter<GratitudeDeleteState> emit) async {
    GratitudeDeleteRepo gratitudeDeleteRepo = GratitudeDeleteRepo();
    emit(GratitudeDeleteLoadingState());
    final result = await gratitudeDeleteRepo.deleteRepo(event.id);
    if (result == true) {
      emit(GratitudeDeleteSuccessState());
    } else {
      emit(GratitudeDeleteErrorState());
    }
  }
}
