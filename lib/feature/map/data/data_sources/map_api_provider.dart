import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/data/api_provider.dart';

class MapRemoteData {
  Future<dynamic> getPathRoute(LatLng start, LatLng end) async {
    Response res = await ApiProvider().get(
      'https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson',
    );
    return res;
  }
}
