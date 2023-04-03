part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class LoadEvents extends EventEvent {}

class UpdateEvents extends EventEvent {
  final List<Event> events;

  UpdateEvents(this.events);
  @override
  List<Object> get props => [events];
}
