// visibility_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import 'visibility_event.dart';
import 'visibility_state.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisibilityBloc() : super(VisibilityToggled(visible: false)) {
    on<ToggleVisibilityEvent>(_onToggleVisibility);
  }

  void _onToggleVisibility(
      ToggleVisibilityEvent event, Emitter<VisibilityState> emit) {
    final currentState = state;
    if (currentState is VisibilityToggled) {
      emit(VisibilityToggled(visible: !currentState.visible));
    }
  }
}
