part of 'nav_bar_cubit.dart';

class NavBarState extends Equatable {
  final int selectedDestination;

  const NavBarState({
    required this.selectedDestination,
  });
  factory NavBarState.initial() {
    return const NavBarState(
      selectedDestination: 0,
    );
  }
  @override
  List<Object?> get props => [selectedDestination];

  NavBarState copyWith({
    int? selectedDestination,
  }) {
    return NavBarState(
      selectedDestination: selectedDestination ?? this.selectedDestination,
    );
  }
}
