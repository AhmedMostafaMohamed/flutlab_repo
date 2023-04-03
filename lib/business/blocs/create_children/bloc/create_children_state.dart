part of 'create_children_bloc.dart';

abstract class CreateChildrenState extends Equatable {
  const CreateChildrenState();

  @override
  List<Object?> get props => [];
}

class ChildLoading extends CreateChildrenState {}

class ChildLoaded extends CreateChildrenState {
  final String? name;
  final DateTime? dob;
  final String? languageLevel;
  final String? gender;
  final String? parentId;
  final Child? child;

  ChildLoaded({
    this.name,
    this.dob,
    this.languageLevel,
    this.gender,
    this.parentId,
  }) : child = Child(
          name: name,
          dob: dob,
          languageLevel: languageLevel,
          gender: gender,
        );
  @override
  List<Object?> get props => [name, dob, languageLevel, gender, parentId];
}
