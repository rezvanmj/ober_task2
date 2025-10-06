import 'package:equatable/equatable.dart';
import 'package:task2/feature/map/presentation/manager/status/get_path_status.dart';
import 'package:task2/feature/map/presentation/manager/status/map_status.dart';

class MapState extends Equatable {
  const MapState({
    this.currentLocationStatus,
    this.selectPointsStatus,
    this.getPathRoute,
  });
  final SuccessLocationStatus? currentLocationStatus;
  final SelectPointsStatus? selectPointsStatus;
  final GetPathStatusStatus? getPathRoute;
  MapState copyWith({
    SuccessLocationStatus? newCurrentLocationStatus,
    SelectPointsStatus? newSelectPointStatus,
    GetPathStatusStatus? newGetPathRouteStatus,
  }) {
    return MapState(
      selectPointsStatus: newSelectPointStatus ?? selectPointsStatus,
      getPathRoute: newGetPathRouteStatus ?? getPathRoute,
      currentLocationStatus: newCurrentLocationStatus ?? currentLocationStatus,
    );
  }

  @override
  List<Object?> get props => [
    currentLocationStatus,
    selectPointsStatus,
    getPathRoute,
  ];
}
