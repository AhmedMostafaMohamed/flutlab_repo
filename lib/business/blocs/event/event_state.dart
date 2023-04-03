part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventLoading extends EventState {}

class EventLoaded extends EventState {
  final List<Event> events;

  EventLoaded({this.events = const <Event>[]});
  @override
  List<Object> get props => [events];
}
