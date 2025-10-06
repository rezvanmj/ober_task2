import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:task2/feature/map/data/model/driver_model.dart';

abstract class MapStatus extends Equatable {}

class FailureCurrentLocation extends MapStatus {
  @override
  List<Object?> get props => [];
}

// statuses for selecting points
class SelectPointsStatus extends MapStatus {
  final LatLng? startPoint;
  final LatLng? endPoint;
  final List<LatLng>? routePoints;
  final List<DriverModel>? drivers;

  SelectPointsStatus({
    this.startPoint,
    this.endPoint,
    this.routePoints,
    this.drivers,
  });

  @override
  List<Object?> get props => [startPoint, endPoint, routePoints, drivers];
}

//Getting current location
class SuccessLocationStatus extends MapStatus {
  final LatLng? currentLocation;

  SuccessLocationStatus({this.currentLocation});

  @override
  List<Object?> get props => [currentLocation];
}
