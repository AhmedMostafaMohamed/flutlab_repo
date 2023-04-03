part of 'children_bloc.dart';

abstract class ChildrenState extends Equatable {
  const ChildrenState();

  @override
  List<Object> get props => [];
}

class ChildrenLoading extends ChildrenState {}

class ChildrenLoaded extends ChildrenState {
  final List<Child> children;
  ChildrenLoaded({this.children = const <Child>[]});
  @override
  List<Object> get props => [children];
}
