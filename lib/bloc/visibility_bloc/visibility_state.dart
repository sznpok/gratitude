// visibility_state.dart
import 'package:equatable/equatable.dart';

abstract class VisibilityState extends Equatable {
  const VisibilityState();

  @override
  List<Object> get props => [];
}

class VisibilityToggled extends VisibilityState {
  final bool visible;

  const VisibilityToggled({required this.visible});

  @override
  List<Object> get props => [visible];
}
