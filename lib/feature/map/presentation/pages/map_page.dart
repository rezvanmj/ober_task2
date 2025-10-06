import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:task2/core/constants/app_dimensions.dart';
import 'package:task2/core/constants/app_values.dart';
import 'package:task2/feature/map/data/model/address_model.dart';
import 'package:task2/feature/map/presentation/manager/status/get_address_status.dart';
import 'package:task2/feature/map/presentation/manager/status/get_path_status.dart';
import 'package:task2/feature/map/presentation/manager/status/search_address_status.dart';

import '../../../../core/widgets/app_space.dart';
import '../../../../core/widgets/failure_widget.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../manager/map_bloc.dart';
import '../manager/map_event.dart';
import '../manager/map_state.dart';
import '../manager/status/map_status.dart';
import '../widget/map_widget.dart';
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
  String? sourceAddress;
  String? destinationAddress;

  final Distance _determinedDistance = Distance();

  // mapController.move(currentLatLng, 15);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        // currentLocation = state.
        return Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: _body(context, state),
          ),
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
      if (state.getPathRoute is GetPathRouteSuccessStatus) {
        var status = state.getPathRoute as GetPathRouteSuccessStatus;
        routePoints = status.routePoints ?? [];
      }

      return Stack(
        children: [
          MapWidget(
            mapController: mapController,
            startPoint: startPoint,
            endPoint: endPoint,
            routePoints: routePoints,
            currentLocation: currentLocation,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: (endPoint != null && startPoint != null)
                ? SafeArea(child: _distance(context, state))
                : SafeArea(child: _selectLocationButton()),
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SearchWidget(
                  mapController: mapController ?? MapController(),
                  currentLocation: currentLocation ?? LatLng(0.0, 0.0),
                  searchController: searchController,
                  // isSelectedPoints: startPoint != null && endPoint != null,
                ),

                SizedBox(height: 260, child: _searchResult(context, state)),
              ],
            ),
          ),
        ],
      );
    } else {
      return LoadingWidget();
    }
  }

  Widget _searchResult(BuildContext context, MapState state) {
    if (state.searchAddressStatus is SearchAddressSuccess) {
      var status = state.searchAddressStatus as SearchAddressSuccess;
      List<AddressModel>? addresses = status.searchedAddresses ?? [];

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppDimensions.horizontalPadding,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimensions.buttonRadius),
            ),
          ),
          child: addresses.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(child: Text('Nothing found!')),
                )
              : _addressList(context, addresses, state),
        ),
      );
    }
    if (state.searchAddressStatus is SearchAddressInit) {
      return SizedBox();
    }
    if (state.searchAddressStatus is SearchAddressLoading) {
      return _loading(context);
    }
    return SizedBox();
  }

  Padding _loading(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.horizontalPadding,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.buttonRadius),
          ),
        ),
        child: LoadingWidget(),
      ),
    );
  }

  Widget _addressList(
    BuildContext context,
    List<AddressModel> addresses,
    MapState state,
  ) {
    return SizedBox(
      height: AppValues.fullHeight(context) / 2,
      child: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            double lat = double.parse(addresses[index].lat ?? '0.0');
            double lng = double.parse(addresses[index].lon ?? '0.0');

            context.read<MapBloc>().add(
              SelectAddressEvent(selectedAddress: addresses[index]),
            );
            if (startPoint == null) {
              LatLng point = LatLng(lat, lng);
              context.read<MapBloc>().add(SelectPointsEvent(startPoint: point));
              mapController?.move(point, 15);
              context.read<MapBloc>().add(SearchAddressEvent());
            } else if (endPoint == null && startPoint != null) {
              LatLng point = LatLng(lat, lng);
              context.read<MapBloc>().add(
                SelectPointsEvent(endPoint: point, startPoint: startPoint),
              );
              mapController?.move(point, 15);
              context.read<MapBloc>().add(SearchAddressEvent());
            }
          },
          child: _addressItem(addresses, index),
        ),
      ),
    );
  }

  Widget _addressItem(List<AddressModel> addresses, int index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            '${addresses[index].address?.country ?? ''} ${addresses[index].address?.state ?? ''} ${addresses[index].address?.city ?? ''}',
          ),
        ),
        Divider(thickness: 0.2),
      ],
    );
  }

  Widget _selectLocationButton() {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {},
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

  Widget _distance(BuildContext context, MapState state) {
    final distance = getDistanceInKm();
    if (distance == null) return const SizedBox.shrink();
    const double baseFare = 2.0;
    const double farePerKm = 1.5;

    double fare = baseFare + (distance * farePerKm);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _tripInfo(distance, fare),
        const SizedBox(height: 10),
        _requestButton(context, state),
      ],
    );
  }

  Widget _requestButton(BuildContext context, MapState state) {
    return Row(
      children: [
        Expanded(
          child: BlocListener<MapBloc, MapState>(
            listenWhen: (previous, current) {
              // Only trigger listener when the state changes to SuccessGetAddress
              return current.getAddressStatus is SuccessGetAddress &&
                  previous.getAddressStatus != current.getAddressStatus;
            },
            listener: (BuildContext context, state) {
              if (state.getAddressStatus is SuccessGetAddress) {
                sourceAddress =
                    (state.getAddressStatus as SuccessGetAddress)
                        .sourceAddress ??
                    '';
                destinationAddress =
                    (state.getAddressStatus as SuccessGetAddress)
                        .destinationAddress ??
                    '';
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(child: _tripInfoDialog(context));
                  },
                );
              }
            },
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
                context.read<MapBloc>().add(RequestTripEvent());
              },
              child: state.getAddressStatus is LoadingGetAddress
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Request Trip'),
                        AppSpace(width: 5),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ],
                    )
                  : const Text('Request Trip'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tripInfoDialog(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Trip Requested Successfully',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          AppSpace(height: 40),
          Wrap(
            children: [
              Text(
                'Source Address : ',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(sourceAddress ?? ''),
            ],
          ),

          AppSpace(height: 20),
          Wrap(
            children: [
              Text(
                'Destination Address : ',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(destinationAddress ?? ''),
            ],
          ),
          AppSpace(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    startPoint = null;
                    endPoint = null;
                    routePoints = [];
                    context.read<MapBloc>().add(
                      SelectPointsEvent(startPoint: null, endPoint: null),
                    );
                  },
                  child: Text(
                    'Reset',
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium?.copyWith(color: Colors.red),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<MapBloc>().add(InitDriversEvent());
                  },
                  child: Text('Confirm Ride'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tripInfo(double distance, double fare) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Distance: ${distance.toStringAsFixed(2)} KM',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            'Fare: €${fare.toStringAsFixed(2)}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
