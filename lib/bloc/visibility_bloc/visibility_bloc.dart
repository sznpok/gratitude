import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'visibility_event.dart';

part 'visibility_state.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisibilityBloc() : super(PasswordHidden());

  @override
  Stream<VisibilityState> mapEventToState(VisibilityEvent event) async* {
    if (event is ToggleVisibility) {
      if (state is PasswordVisible) {
        yield PasswordHidden();
      } else {
        yield PasswordVisible();
      }
    }
  }
}
