import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gratitude_app/detail_gratitude/repo/update_gratitude_repo.dart';
import 'package:meta/meta.dart';

part 'update_gratitude_event.dart';

part 'update_gratitude_state.dart';

class UpdateGratitudeBloc
    extends Bloc<UpdateGratitudeEvent, UpdateGratitudeState> {
  UpdateGratitudeBloc() : super(UpdateGratitudeInitial()) {
    on<OnUpdateGratitudeEvent>(onUpdateGratitudeEvent);
  }

  FutureOr<void> onUpdateGratitudeEvent(
      OnUpdateGratitudeEvent event, Emitter<UpdateGratitudeState> emit) async {
    UpdateGratitudeRepo updateGratitudeRepo = UpdateGratitudeRepo();
    emit(UpdateGratitudeLoadingState());
    final result = await updateGratitudeRepo.update(
        text: event.title, id: event.id, imagePath: event.image);
    if (result == true) {
      emit(UpdateGratitudeSuccessState());
    } else {
      emit(UpdateGratitudeErrorState());
    }
  }
}
