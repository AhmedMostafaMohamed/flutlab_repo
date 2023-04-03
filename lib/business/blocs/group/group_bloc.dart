import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schoner_tag/modules/event/components/instructors.dart';

import '../../../data/models/child.dart';
import '../../../data/models/group.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/group/group_repository.dart';

part 'group_event.dart';
part 'group_state.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  final GroupRepository _groupRepository;
  StreamSubscription? _groupSubscription;
  GroupBloc({required GroupRepository groupRepository})
      : _groupRepository = groupRepository,
        super(GroupsLoading()) {
    on<LoadGroups>(_onLoadGroups);
    on<UpdateGroups>(_onUpdateGroups);
    on<CreateGroup>(_onCreateGroup);
  }

  void _onLoadGroups(LoadGroups event, Emitter<GroupState> emit) {
    _groupSubscription?.cancel();
    _groupSubscription = _groupRepository
        .getAllGroups(event.eventId)
        .listen((group) => add(UpdateGroups(group)));
  }

  void _onCreateGroup(CreateGroup event, Emitter<GroupState> emit) {
    Group group = Group(name: event.name, location: event.location);
    _groupSubscription?.cancel();
    _groupRepository.createGroupChildren(event.eventId, event.subscribers,
        event.name, event.location, event.instructors);
    add(LoadGroups(event.eventId));
  }

  FutureOr<void> _onUpdateGroups(UpdateGroups event, Emitter<GroupState> emit) {
    emit(GroupsLoaded(groups: event.groups));
  }
}
