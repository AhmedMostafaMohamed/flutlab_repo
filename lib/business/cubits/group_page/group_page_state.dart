part of 'group_page_cubit.dart';

class GroupPageState extends Equatable {
  final List<Child> myChildren;
  final List<User> myInstructors;

  const GroupPageState({required this.myChildren, required this.myInstructors});
  factory GroupPageState.initial() {
    return const GroupPageState(myChildren: [], myInstructors: []);
  }

  @override
  List<Object> get props => [myChildren, myInstructors];
  GroupPageState copyWith(
      {List<Child>? myChildren, List<User>? myInstructors}) {
    return GroupPageState(
        myChildren: myChildren ?? this.myChildren,
        myInstructors: myInstructors ?? this.myInstructors);
  }
}

class Deleted extends GroupPageState {
  Deleted({required super.myChildren, required super.myInstructors});
}

class NotDeleted extends GroupPageState {
  NotDeleted({required super.myChildren, required super.myInstructors});
}

class LoadingInstructors extends GroupPageState {
  LoadingInstructors({required super.myChildren, required super.myInstructors});
}

class LoadingChildren extends GroupPageState {
  LoadingChildren({required super.myChildren, required super.myInstructors});
}
