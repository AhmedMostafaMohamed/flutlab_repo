part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class LoadGroups extends GroupEvent {
  final String eventId;

  LoadGroups(this.eventId);
  @override
  List<Object> get props => [eventId];
}

class LoadChildren extends GroupEvent {
  final String eventId;
  final String groupName;

  LoadChildren(this.eventId, this.groupName);
  @override
  List<Object> get props => [eventId, groupName];
}

class LoadInstructors extends GroupEvent {
  final String eventId;
  final String groupName;

  LoadInstructors(this.eventId, this.groupName);
  @override
  List<Object> get props => [eventId, groupName];
}

class CreateGroup extends GroupEvent {
  final String name;
  final String location;
  List<Child> subscribers;
  List<User> instructors;
  final String eventId;

  CreateGroup(this.name, this.location, this.eventId, this.subscribers,
      this.instructors);
  @override
  List<Object> get props => [name, location, eventId, subscribers, instructors];
}

class UpdateGroups extends GroupEvent {
  final List<Group> groups;

  UpdateGroups(this.groups);
  @override
  List<Object> get props => [groups];
}

class UpdateChildren extends GroupEvent {
  final List<Child> children;

  UpdateChildren(this.children);
  @override
  List<Object> get props => [children];
}

class UpdateInstructors extends GroupEvent {
  final List<User> instructors;

  UpdateInstructors(this.instructors);
  @override
  List<Object> get props => [instructors];
}
