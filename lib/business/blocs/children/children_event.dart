part of 'children_bloc.dart';

abstract class ChildrenEvent extends Equatable {
  const ChildrenEvent();

  @override
  List<Object> get props => [];
}

class LoadChildren extends ChildrenEvent {
  final String parentId;

  LoadChildren(this.parentId);
  @override
  List<Object> get props => [parentId];
}

class UpdateChildren extends ChildrenEvent {
  final List<Child> children;

  UpdateChildren(this.children);
  @override
  List<Object> get props => [children];
}

class CreateChild extends ChildrenEvent {
  final Child child;

  CreateChild(this.child);
  @override
  List<Object> get props => [child];
}
