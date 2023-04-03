import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/models/child.dart';
import '../../../../data/repositories/children/children_repository.dart';

part 'children_event.dart';
part 'children_state.dart';

class ChildrenBloc extends Bloc<ChildrenEvent, ChildrenState> {
  final ChildrenRepository _childrenRepository;
  StreamSubscription? _childrenSubscription;
  ChildrenBloc({required ChildrenRepository childrenRepository})
      : _childrenRepository = childrenRepository,
        super(ChildrenLoading()) {
    on<LoadChildren>(_onLoadChildren);
    on<UpdateChildren>(_onUpdateChildren);
    on<CreateChild>(_onCreateChild);
  }

  FutureOr<void> _onLoadChildren(
      LoadChildren event, Emitter<ChildrenState> emit) {
    _childrenSubscription?.cancel();
    _childrenSubscription = _childrenRepository
        .getChildren(event.parentId)
        .listen((child) => add(UpdateChildren(child)));
  }

  FutureOr<void> _onUpdateChildren(
      UpdateChildren event, Emitter<ChildrenState> emit) {
    emit(ChildrenLoaded(children: event.children));
  }

  FutureOr<void> _onCreateChild(
      CreateChild event, Emitter<ChildrenState> emit) {
    _childrenSubscription?.cancel();
    _childrenRepository.addChild(event.child);
  }
}
