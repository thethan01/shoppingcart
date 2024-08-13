part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class InitProducts extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class LoadMoreAllProducts extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class LoadMoreHotProducts extends HomeEvent {
  @override
  List<Object?> get props => [];
}
