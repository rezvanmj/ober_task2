import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/widgets/failure_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../manager/map_bloc.dart';
import '../manager/map_event.dart';
import '../manager/map_state.dart';
import '../manager/status/get_path_status.dart';
import '../manager/status/map_status.dart' hide GetPathRouteSuccessStatus;
import '../widget/search_widget.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController? mapController = MapController();
  TextEditingController searchController = TextEditingController();
  LatLng? currentLocation;
  LatLng? startPoint;
  LatLng? endPoint;
  List<LatLng>? routePoints;

  final Distance _determinedDistance = Distance();

  // mapController.move(currentLatLng, 15);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        // currentLocation = state.
        return Scaffold(
          body: _body(context, state),
          // floatingActionButton:,
        );
      },
    );
  }

  Widget _body(BuildContext context, MapState state) {
    if (state.currentLocationStatus is FailureCurrentLocation) {
      return FailureWidget();
    } else if (state.currentLocationStatus is SuccessLocationStatus) {
      currentLocation = state.currentLocationStatus?.currentLocation;
      startPoint = state.selectPointsStatus?.startPoint;
      endPoint = state.selectPointsStatus?.endPoint;
      routePoints = state.selectPointsStatus?.routePoints ?? [];
      return Stack(
        children: [
          _map(),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: (endPoint != null && startPoint != null)
                ? SafeArea(child: _distance(context))
                : SafeArea(child: _selectLocationButton()),
          ),
          SafeArea(
            child: SearchWidget(
              mapController: mapController ?? MapController(),
              currentLocation: currentLocation ?? LatLng(0.0, 0.0),
              searchController: searchController,
            ),
          ),
        ],
      );
    } else {
      return LoadingWidget();
    }
  }

  Widget _selectLocationButton() {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        if (startPoint == null && endPoint == null) {
          // startSelectingPoints();
        } else {}
      },
      child: startPoint == null
          ? Text('Select Source')
          : (endPoint == null && startPoint != null)
          ? Text('Select Destination')
          : SizedBox(),
    );
  }

  double? getDistanceInKm() {
    if (startPoint == null || endPoint == null) return null;
    return _determinedDistance.as(LengthUnit.Kilometer, startPoint!, endPoint!);
  }

  Widget _distance(BuildContext context) {
    final distance = getDistanceInKm();
    if (distance == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
          ),
          child: Text(
            'Distance: ${distance.toStringAsFixed(2)}KM',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Request'),
                      content: const Text('Success'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // startSelectingPoints();
                          },
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Request'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _map() {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: currentLocation ?? LatLng(51.5, -0.09),
        initialZoom: 13,
        onTap: (tapPos, point) {
          if (startPoint == null) {
            context.read<MapBloc>().add(SelectPointsEvent(startPoint: point));
          } else {
            context.read<MapBloc>().add(
              SelectPointsEvent(endPoint: point, startPoint: startPoint),
            );

            context.read<MapBloc>().add(GetPathRoute());
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
  }
}
