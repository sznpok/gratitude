import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gratitude_app/post_gratitude/repo/post_gratitude_repo.dart';
import 'package:meta/meta.dart';

part 'post_gratitude_event.dart';

part 'post_gratitude_state.dart';

class PostGratitudeBloc extends Bloc<PostGratitudeEvent, PostGratitudeState> {
  PostGratitudeBloc() : super(PostGratitudeInitial()) {
    on<OnPostGratitudeEvent>(postGratitudeEvent);
  }

  FutureOr<void> postGratitudeEvent(
      OnPostGratitudeEvent event, Emitter<PostGratitudeState> emit) async {
    PostGratitudeRepo postGratitudeRepo = PostGratitudeRepo();
    emit(PostGratitudeLoadingState());
    final result =
        await postGratitudeRepo.postGratitude(event.title, event.profile);
    if (result == true) {
      emit(PostGratitudeSuccessState());
    } else {
      emit(PostGratitudeErrorState());
    }
  }
}
