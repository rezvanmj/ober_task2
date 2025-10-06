import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:task2/feature/map/data/model/route_path_model.dart';
import 'package:task2/feature/map/domain/use_cases/get_route_usecase.dart';
import 'package:task2/feature/map/presentation/manager/status/get_path_status.dart';
import 'package:task2/feature/map/presentation/manager/status/map_status.dart';

import '../../../../core/exceptions/failure.dart';
import 'map_event.dart' as event;
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GetRouteUsecase getRouteUsecase;

  MapBloc({required this.getRouteUsecase}) : super(MapState()) {
    on<event.GetCurrentLocationEvent>(_getCurrentLocation);
    on<SelectPointsEvent>(_selectPoints);
    on<GetPathRouteEvent>(_getPath);
  }

  FutureOr<void> _getPath(event, emit) async {
    emit(state.copyWith(newGetPathRouteStatus: GetPathRouteLoadingStatus()));

    Either<Failure, RoutePathModel> response = await getRouteUsecase({
      'start': state.selectPointsStatus?.startPoint,
      'end': state.selectPointsStatus?.endPoint,
    });
    response.fold(
      (error) {
        emit(state.copyWith(newGetPathRouteStatus: GetPathRouteFailedStatus()));
      },
      (RoutePathModel data) {
        final cords = (data.routes?[0].geometry?.coordinates ?? []) as List;
        var routes = cords
            .map((c) => LatLng(c[1].toDouble(), c[0].toDouble()))
            .toList();
        emit(
          state.copyWith(
            newGetPathRouteStatus: GetPathRouteSuccessStatus(
              routePoints: routes,
            ),
          ),
        );
      },
    );
  }

  FutureOr<void> _selectPoints(event, emit) {
    if (event.startPoint != null) {
      emit(
        state.copyWith(
          newSelectPointStatus: SelectPointsStatus(
            startPoint:
                state.selectPointsStatus?.startPoint ?? event.startPoint,
            endPoint: event.endPoint,
          ),
        ),
      );
    } else {
      if (event.startPoint == null) {
        //RESET data
        emit(
          state.copyWith(
            newSelectPointStatus: SelectPointsStatus(
              startPoint: null,
              endPoint: null,
            ),
            newGetPathRouteStatus: GetPathRouteSuccessStatus(routePoints: null),
          ),
        );
      } else {
        emit(
          state.copyWith(
            newSelectPointStatus: SelectPointsStatus(
              startPoint: event.startPoint,
            ),
          ),
        );
      }
    }
  }

  FutureOr<void> _getCurrentLocation(event, emit) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();
    final currentLatLng = LatLng(position.latitude, position.longitude);
    emit(
      state.copyWith(
        newCurrentLocationStatus: SuccessLocationStatus(
          currentLocation: currentLatLng,
        ),
      ),
    );
  }

  // Future<void> getRoute() async {
  //   if (startPoint != null && endPoint != null) {
  //     final url =
  //         'https://router.project-osrm.org/route/v1/driving/${startPoint?.longitude},${startPoint?.latitude};${endPoint.value?.longitude},${endPoint.value?.latitude}?overview=full&geometries=geojson';
  //     final response = await http.get(Uri.parse(url));
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       final cords = data['routes'][0]['geometry']['coordinates'] as List;
  //       // routePoints.value = cords
  //       //     .map((c) => LatLng(c[1].toDouble(), c[0].toDouble()))
  //       //     .toList();
  //     }
  //   }
  // }
}
