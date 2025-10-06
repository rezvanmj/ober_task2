import 'package:dartz/dartz.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/exceptions/failure.dart';
import '../../data/model/route_path_model.dart';

abstract class MapRepository {
  Future<Either<Failure, RoutePathModel>> getPathRoute({
    required LatLng start,
    required LatLng end,
  });
}
