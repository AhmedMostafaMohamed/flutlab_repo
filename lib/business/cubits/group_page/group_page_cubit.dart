import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/child.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/group/group_repository.dart';

part 'group_page_state.dart';

class GroupPageCubit extends Cubit<GroupPageState> {
  final GroupRepository _groupRepository;
  StreamSubscription? _groupSubscription;
  GroupPageCubit({required GroupRepository groupRepository})
      : _groupRepository = groupRepository,
        super(GroupPageState.initial());
  void loadChildrenAndInstructors(String eventId, String groupName) {
    emit(LoadingChildren(
        myChildren: state.myChildren, myInstructors: state.myInstructors));
    _groupSubscription?.cancel();
    _groupSubscription = _groupRepository
        .getGroupInstructors(eventId, groupName)
        .listen((instructor) => emit(state.copyWith(
              myInstructors: instructor,
            )));
    _groupSubscription = _groupRepository
        .getGroupChildren(eventId, groupName)
        .listen((child) => emit(state.copyWith(
              myChildren: child,
            )));
    emit(LoadingInstructors(
        myChildren: state.myChildren, myInstructors: state.myInstructors));
  }

  void deleteGroup(String eventId, String groupName) async {
    emit(NotDeleted(
        myChildren: state.myChildren, myInstructors: state.myInstructors));
    bool deleted = await _groupRepository.deleteGroup(groupName, eventId);
    if (deleted) {
      emit(Deleted(
          myChildren: state.myChildren, myInstructors: state.myInstructors));
    }
  }
}
