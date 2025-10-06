import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:task2/feature/map/data/model/address_model.dart';
import 'package:task2/feature/map/data/model/driver_model.dart';
import 'package:task2/feature/map/data/model/route_path_model.dart';
import 'package:task2/feature/map/domain/use_cases/convert_lattng_usecase.dart';
import 'package:task2/feature/map/domain/use_cases/get_route_usecase.dart';
import 'package:task2/feature/map/domain/use_cases/search_location_usecase.dart';
import 'package:task2/feature/map/presentation/manager/status/get_address_status.dart';
import 'package:task2/feature/map/presentation/manager/status/get_path_status.dart';
import 'package:task2/feature/map/presentation/manager/status/map_status.dart';
import 'package:task2/feature/map/presentation/manager/status/search_address_status.dart';

import '../../../../core/exceptions/failure.dart';
import 'map_event.dart' as event;
import 'map_event.dart';
import 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GetRouteUsecase getRouteUsecase;
  SearchLocationUsecase searchLocationUsecase;
  ConvertLattngUsecase convertLattngUsecase;

  MapBloc({
    required this.getRouteUsecase,
    required this.searchLocationUsecase,
    required this.convertLattngUsecase,
  }) : super(MapState()) {
    on<event.GetCurrentLocationEvent>(_getCurrentLocation);
    on<SelectPointsEvent>(_selectPoints);
    on<GetPathRouteEvent>(_getPath);
    on<SearchAddressEvent>(_searchAddress);
    on<SelectAddressEvent>(_selectAddress);
    on<RequestTripEvent>(_requestTrip);
    on<InitDriversEvent>(_addDriver);
  }

  String? sourceAddress = '';
  String? destinationAddress = '';

  FutureOr<void> _addDriver(event, emit) async {
    final userLocation = state.selectPointsStatus?.startPoint;
    // 3 random drivers
    if (userLocation != null) {
      List<DriverModel> drivers = [
        DriverModel(
          id: '1',
          location: LatLng(
            userLocation.latitude + 0.005,
            userLocation.longitude + 0.005,
          ),
        ),
        DriverModel(
          id: '2',
          location: LatLng(
            userLocation.latitude - 0.009,
            userLocation.longitude - 0.005,
          ),
        ),
        DriverModel(
          id: '3',
          location: LatLng(
            userLocation.latitude + 0.005,
            userLocation.longitude - 0.009,
          ),
        ),
      ];

      emit(
        state.copyWith(
          newSelectPointStatus: SelectPointsStatus(
            startPoint: state.selectPointsStatus?.startPoint,
            endPoint: state.selectPointsStatus?.endPoint,
            drivers: drivers,
          ),
        ),
      );
      Either<Failure, RoutePathModel> response = await getRouteUsecase({
        'start': drivers[0].location,
        'end': userLocation,
      });
      await response.fold((error) async {}, (RoutePathModel data) async {
        final cords = (data.routes?[0].geometry?.coordinates ?? []) as List;
        var routes = cords
            .map((c) => LatLng(c[1].toDouble(), c[0].toDouble()))
            .toList();
        for (int i = 0; i < routes.length; i++) {
          await Future.delayed(const Duration(milliseconds: 500));

          final updatedDrivers = List<DriverModel>.from(drivers);

          updatedDrivers[0] = updatedDrivers[0].copyWith(location: routes[i]);

          emit(
            state.copyWith(
              newSelectPointStatus: SelectPointsStatus(
                startPoint: state.selectPointsStatus?.startPoint,
                endPoint: state.selectPointsStatus?.endPoint,
                drivers: updatedDrivers,
              ),
            ),
          );
        }
      });
    }
  }

  FutureOr<void> _requestTrip(event, emit) async {
    emit(state.copyWith(newGetAddressStatus: LoadingGetAddress()));

    Either<Failure, AddressModel> sResponse = await convertLattngUsecase({
      'point': state.selectPointsStatus?.startPoint,
    });
    sResponse.fold(
      (error) {
        emit(state.copyWith(newGetAddressStatus: FailedGetAddress()));
      },
      (AddressModel data) {
        sourceAddress = data.displayName;
      },
    );
    Either<Failure, AddressModel> dResponse = await convertLattngUsecase({
      'point': state.selectPointsStatus?.endPoint,
    });
    dResponse.fold(
      (error) {
        emit(state.copyWith(newGetAddressStatus: FailedGetAddress()));
      },
      (AddressModel data) {
        destinationAddress = data.displayName;
      },
    );
    emit(
      state.copyWith(
        newGetAddressStatus: SuccessGetAddress(
          sourceAddress: sourceAddress,
          destinationAddress: destinationAddress,
        ),
      ),
    );
  }

  FutureOr<void> _selectAddress(event, emit) {
    emit(state.copyWith(newSearchAddressStatus: SearchAddressInit()));
  }

  FutureOr<void> _searchAddress(event, emit) async {
    if (event.query == null || event.query == '') {
      emit(state.copyWith(newSearchAddressStatus: SearchAddressInit()));
    } else {
      emit(state.copyWith(newSearchAddressStatus: SearchAddressLoading()));
      Either<Failure, List<AddressModel>> response =
          await searchLocationUsecase({'query': event.query});
      response.fold(
        (error) {
          emit(state.copyWith(newSearchAddressStatus: SearchAddressFailed()));
        },
        (List<AddressModel> data) {
          emit(
            state.copyWith(
              newSearchAddressStatus: SearchAddressSuccess(
                searchedAddresses: data,
              ),
            ),
          );
        },
      );
    }
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
              drivers: [],
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
}
