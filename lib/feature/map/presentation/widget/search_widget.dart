import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/widgets/app_text_field.dart';
import '../manager/map_bloc.dart';
import '../manager/map_event.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.currentLocation,
    required this.searchController,
    required this.mapController,
    required this.isSelectedPoints,
  });
  final TextEditingController searchController;
  final MapController mapController;
  final LatLng currentLocation;
  final bool isSelectedPoints;
  @override
  Widget build(BuildContext context) {
    Timer? debounce;
    return Align(
      alignment: Alignment.topRight,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppTextField(
                onChanged: (value) {
                  if (isSelectedPoints) {
                  } else {
                    if (debounce?.isActive ?? false) debounce?.cancel();
                    debounce = Timer(const Duration(milliseconds: 900), () {
                      if (value.length >= 4) {
                        context.read<MapBloc>().add(
                          SearchAddressEvent(query: value),
                        );
                      }
                    });
                    if (value.length < 2) {
                      context.read<MapBloc>().add(SearchAddressEvent());
                    }
                  }
                },
                hint: 'Search',
                label: 'Search',
                controller: searchController,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              onPressed: () {
                context.read<MapBloc>().add(GetCurrentLocationEvent());
                mapController.move(currentLocation, 15);
              },
              child: const Icon(Icons.gps_fixed_outlined, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
