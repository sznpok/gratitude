import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gratitude_app/list_gratitude/repo/list_gratitude_repo.dart';
import 'package:meta/meta.dart';

import '../model/list_gratitude_model.dart';

part 'list_gratitude_event.dart';

part 'list_gratitude_state.dart';

class ListGratitudeBloc extends Bloc<ListGratitudeEvent, ListGratitudeState> {
  ListGratitudeBloc() : super(ListGratitudeInitial()) {
    on<LoadingListGratitudeEvent>(listGratitudeEvent);
  }

  FutureOr<void> listGratitudeEvent(
      LoadingListGratitudeEvent event, Emitter<ListGratitudeState> emit) async {
    ListGratitudeRepo repo = ListGratitudeRepo();
    final result = await repo.gratitudeRepo();
    if (result.gg!.isNotEmpty) {
      emit(ListGratitudeSuccessState(result));
    } else {
      emit(ListGratitudeErrorState(result.toString()));
    }
  }
}
