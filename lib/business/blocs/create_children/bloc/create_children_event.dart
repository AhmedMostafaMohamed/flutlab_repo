part of 'create_children_bloc.dart';

abstract class CreateChildrenEvent extends Equatable {
  const CreateChildrenEvent();

  @override
  List<Object?> get props => [];
}

class UpdateChild extends CreateChildrenEvent {
  final String? name;
  final DateTime? dob;
  final String? languageLevel;
  final String? gender;
  final String? parentId;
  final Child? child;

  UpdateChild(
      {this.name,
      this.dob,
      this.languageLevel,
      this.gender,
      this.parentId,
      this.child});
  @override
  List<Object?> get props => [name, dob, languageLevel, gender, parentId];
}

class ConfirmChild extends CreateChildrenEvent {
  final Child child;

  const ConfirmChild({required this.child});
  @override
  List<Object?> get props => [child];
}
