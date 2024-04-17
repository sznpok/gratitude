import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'list_gratitude_event.dart';
part 'list_gratitude_state.dart';

class ListGratitudeBloc extends Bloc<ListGratitudeEvent, ListGratitudeState> {
  ListGratitudeBloc() : super(ListGratitudeInitial()) {
    on<ListGratitudeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
