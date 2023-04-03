import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schoner_tag/data/repositories/children/children_repository.dart';

import '../../../../data/models/child.dart';
import '../../children/children_bloc.dart';

part 'create_children_event.dart';
part 'create_children_state.dart';

class CreateChildrenBloc
    extends Bloc<CreateChildrenEvent, CreateChildrenState> {
  final ChildrenBloc _childrenBloc;
  final ChildrenRepository _childrenRepository;
  StreamSubscription? _childrenSubscription;
  StreamSubscription? _addChildSubscription;
  CreateChildrenBloc({
    required ChildrenBloc childrenBloc,
    required ChildrenRepository childrenRepository,
  })  : _childrenBloc = childrenBloc,
        _childrenRepository = childrenRepository,
        super(childrenBloc.state is ChildrenLoaded
            ? ChildLoaded()
            : ChildLoading()) {
    _childrenSubscription = _childrenBloc.stream.listen(
      (event) {
        if (state is ChildrenLoaded) {}
      },
    );
    on<CreateChildrenEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
