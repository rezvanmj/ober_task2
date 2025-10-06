import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

abstract class GetPathStatusStatus extends Equatable {}

// Statuses for getting rout
class GetPathRouteSuccessStatus extends GetPathStatusStatus {
  final List<LatLng>? routePoints;

  GetPathRouteSuccessStatus({this.routePoints});

  @override
  List<Object?> get props => [routePoints];
}

class GetPathRouteLoadingStatus extends GetPathStatusStatus {
  GetPathRouteLoadingStatus();

  @override
  List<Object?> get props => [];
}

class GetPathRouteFailedStatus extends GetPathStatusStatus {
  GetPathRouteFailedStatus();

  @override
  List<Object?> get props => [];
}
