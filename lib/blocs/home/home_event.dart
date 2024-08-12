part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class InitProducts extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class LoadMoreProducts extends HomeEvent {
  @override
  List<Object?> get props => [];
}
