import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schoner_tag/data/repositories/event/event_repository.dart';

import '../../../data/models/event.dart';
part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final EventRepository _eventRepository;
  StreamSubscription? _eventSubscription;
  EventBloc({required EventRepository eventRepository})
      : _eventRepository = eventRepository,
        super(EventLoading()) {
    on<LoadEvents>(_onLoadEvents);
    on<UpdateEvents>(_onUpdateEvents);
  }

  void _onLoadEvents(LoadEvents event, Emitter<EventState> emit) {
    _eventSubscription?.cancel();
    _eventSubscription = _eventRepository
        .getAllEvents()
        .listen((event) => add(UpdateEvents(event)));
  }

  FutureOr<void> _onUpdateEvents(UpdateEvents event, Emitter<EventState> emit) {
    emit(EventLoaded(events: event.events));
  }
}
