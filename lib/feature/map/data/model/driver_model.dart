import 'package:latlong2/latlong.dart';

class DriverModel {
  String id;
  LatLng location;

  DriverModel({required this.id, required this.location});
  DriverModel copyWith({String? id, LatLng? location}) {
    return DriverModel(id: id ?? this.id, location: location ?? this.location);
  }
}
