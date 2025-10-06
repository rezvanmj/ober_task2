import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';
import 'package:task2/feature/map/data/model/address_model.dart';

import '../../../../core/exceptions/failure.dart';
import '../../data/model/route_path_model.dart';

abstract class MapRepository {
  Future<Either<Failure, RoutePathModel>> getPathRoute({
    required LatLng start,
    required LatLng end,
  });
  Future<Either<Failure, List<AddressModel>>> searchAddress({
    required String query,
  });

  Future<Either<Failure, AddressModel>> getAddress({required LatLng point});
}
