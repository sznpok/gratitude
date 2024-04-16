// visibility_event.dart
import 'package:equatable/equatable.dart';

abstract class VisibilityEvent extends Equatable {
  const VisibilityEvent();

  @override
  List<Object> get props => [];
}

class ToggleVisibilityEvent extends VisibilityEvent {}
