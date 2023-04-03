part of 'group_bloc.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupsLoading extends GroupState {}

class ChildrenLoading extends GroupState {}

class InstructorsLoading extends GroupState {}

class GroupsLoaded extends GroupState {
  final List<Group> groups;

  GroupsLoaded({this.groups = const <Group>[]});
  @override
  List<Object> get props => [groups];
}

class ChildrenLoaded extends GroupState {
  final List<Child> children;

  ChildrenLoaded({this.children = const <Child>[]});
  @override
  List<Object> get props => [children];
}

class InstructorsLoaded extends GroupState {
  final List<User> instructors;

  InstructorsLoaded({this.instructors = const <User>[]});
  @override
  List<Object> get props => [instructors];
}
