import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../data/model/driver_model.dart';
import '../manager/map_bloc.dart';
import '../manager/map_event.dart';
import '../manager/map_state.dart';
import '../manager/status/map_status.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
    required this.mapController,
    required this.currentLocation,
    required this.routePoints,
    required this.startPoint,
    required this.endPoint,
  });
  final MapController? mapController;
  final LatLng? currentLocation;
  final List<LatLng>? routePoints;
  final LatLng? startPoint;
  final LatLng? endPoint;
  @override
  Widget build(BuildContext context) {
    return _map(context);
  }

  Widget _map(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        List<DriverModel> drivers = [];
        if (state.selectPointsStatus is SelectPointsStatus) {
          var status = state.selectPointsStatus as SelectPointsStatus;
          drivers = status.drivers ?? [];
        }

        return FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: currentLocation ?? LatLng(51.5, -0.09),
            initialZoom: 13,
            onTap: (tapPos, point) {
              if (startPoint == null) {
                context.read<MapBloc>().add(
                  SelectPointsEvent(startPoint: point),
                );
              } else {
                context.read<MapBloc>().add(
                  SelectPointsEvent(endPoint: point, startPoint: startPoint),
                );
                context.read<MapBloc>().add(GetPathRouteEvent());
              }
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.map_sample_app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  width: 80,
                  height: 80,
                  point: currentLocation ?? LatLng(51.5, -0.09),
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
                if (startPoint != null)
                  Marker(
                    point: startPoint!,
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.flag,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                if (endPoint != null)
                  Marker(
                    point: endPoint!,
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.flag,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                // Drivers
                ...drivers.map(
                  (driver) => Marker(
                    point: driver.location,
                    child: const Icon(
                      Icons.local_taxi,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            if (routePoints?.isNotEmpty ?? false)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: routePoints ?? [],
                    strokeWidth: 4,
                    color: Colors.blue,
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
