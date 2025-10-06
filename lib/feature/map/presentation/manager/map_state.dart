import 'package:equatable/equatable.dart';
import 'package:task2/feature/map/presentation/manager/status/get_address_status.dart';
import 'package:task2/feature/map/presentation/manager/status/get_path_status.dart';
import 'package:task2/feature/map/presentation/manager/status/map_status.dart';
import 'package:task2/feature/map/presentation/manager/status/search_address_status.dart';

class MapState extends Equatable {
  const MapState({
    this.currentLocationStatus,
    this.selectPointsStatus,
    this.getPathRoute,
    this.searchAddressStatus,
    this.getAddressStatus,
  });
  final SuccessLocationStatus? currentLocationStatus;
  final SelectPointsStatus? selectPointsStatus;
  final GetPathStatusStatus? getPathRoute;
  final SearchAddressStatus? searchAddressStatus;
  final GetAddressStatus? getAddressStatus;

  MapState copyWith({
    SuccessLocationStatus? newCurrentLocationStatus,
    SelectPointsStatus? newSelectPointStatus,
    GetPathStatusStatus? newGetPathRouteStatus,
    SearchAddressStatus? newSearchAddressStatus,
    GetAddressStatus? newGetAddressStatus,
  }) {
    return MapState(
      searchAddressStatus: newSearchAddressStatus ?? searchAddressStatus,
      selectPointsStatus: newSelectPointStatus ?? selectPointsStatus,
      getPathRoute: newGetPathRouteStatus ?? getPathRoute,
      getAddressStatus: newGetAddressStatus ?? getAddressStatus,
      currentLocationStatus: newCurrentLocationStatus ?? currentLocationStatus,
    );
  }

  @override
  List<Object?> get props => [
    currentLocationStatus,
    selectPointsStatus,
    getPathRoute,
    searchAddressStatus,
    getAddressStatus,
  ];
}
