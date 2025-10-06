import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

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

class GetPathRoute extends MapEvent {
  @override
  List<Object?> get props => [];
}

// class ChangeFormValues extends DynamicFormEvent {
//   //all of form values
//   final Map<String, dynamic>? formValues;
//
//   ChangeFormValues({this.formValues});
//   @override
//   List<Object?> get props => [formValues];
// }
