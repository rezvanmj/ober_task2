import 'package:equatable/equatable.dart';
import 'package:task2/feature/map/presentation/manager/status/get_path_status.dart';
import 'package:task2/feature/map/presentation/manager/status/map_status.dart';
import 'package:task2/feature/map/presentation/manager/status/search_address_status.dart';

class MapState extends Equatable {
  const MapState({
    this.currentLocationStatus,
    this.selectPointsStatus,
    this.getPathRoute,
    this.searchAddressStatus,
  });
  final SuccessLocationStatus? currentLocationStatus;
  final SelectPointsStatus? selectPointsStatus;
  final GetPathStatusStatus? getPathRoute;
  final SearchAddressStatus? searchAddressStatus;

  MapState copyWith({
    SuccessLocationStatus? newCurrentLocationStatus,
    SelectPointsStatus? newSelectPointStatus,
    GetPathStatusStatus? newGetPathRouteStatus,
    SearchAddressStatus? newSearchAddressStatus,
  }) {
    return MapState(
      searchAddressStatus: newSearchAddressStatus ?? searchAddressStatus,
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
    searchAddressStatus,
  ];
}
