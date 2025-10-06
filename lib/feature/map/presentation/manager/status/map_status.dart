import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class MapStatus extends Equatable {}

// statuses for selecting points
class SelectPointsStatus extends MapStatus {
  final LatLng? startPoint;
  final LatLng? endPoint;
  final List<LatLng>? routePoints;

  SelectPointsStatus({this.startPoint, this.endPoint, this.routePoints});

  @override
  List<Object?> get props => [startPoint, endPoint, routePoints];
}

//Getting current location
class SuccessLocationStatus extends MapStatus {
  final LatLng? currentLocation;

  SuccessLocationStatus({this.currentLocation});

  @override
  List<Object?> get props => [currentLocation];
}
