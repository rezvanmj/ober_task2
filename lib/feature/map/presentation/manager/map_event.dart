import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:task2/feature/map/data/model/address_model.dart';

@immutable
abstract class MapEvent extends Equatable {}

class GetCurrentLocationEvent extends MapEvent {
  @override
  List<Object?> get props => [];
}

class GetDistanceEvent extends MapEvent {
  @override
  List<Object?> get props => [];
}

class SelectPointsEvent extends MapEvent {
  final LatLng? startPoint;
  final LatLng? endPoint;

  SelectPointsEvent({this.startPoint, this.endPoint});
  @override
  List<Object?> get props => [startPoint, endPoint];
}

class GetPathRouteEvent extends MapEvent {
  @override
  List<Object?> get props => [];
}

class SearchAddressEvent extends MapEvent {
  final String? query;
  SearchAddressEvent({this.query});
  @override
  List<Object?> get props => [query];
}

class SelectAddressEvent extends MapEvent {
  final AddressModel? selectedAddress;
  SelectAddressEvent({this.selectedAddress});
  @override
  List<Object?> get props => [selectedAddress];
}

class RequestTripEvent extends MapEvent {
  RequestTripEvent();
  @override
  List<Object?> get props => [];
}

class InitDriversEvent extends MapEvent {
  final LatLng? userLocation;
  InitDriversEvent({this.userLocation});
  @override
  List<Object?> get props => [userLocation];
}
