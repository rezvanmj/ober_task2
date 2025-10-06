import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:task2/core/exceptions/failure.dart';
import 'package:task2/feature/map/data/data_sources/map_api_provider.dart';
import 'package:task2/feature/map/data/model/address_model.dart';

import '../../../../core/exceptions/server_exception.dart';
import '../../domain/repositories/map_repository.dart';
import '../model/route_path_model.dart';

class MapRepositoryImpl extends MapRepository {
  MapRemoteData remoteData;

  MapRepositoryImpl({required this.remoteData});

  @override
  Future<Either<Failure, RoutePathModel>> getPathRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      Response response = await remoteData.getPathRoute(start, end);
      RoutePathModel route = RoutePathModel.fromJson(response.data);

      return Right(route);
    } on ServerException catch (error) {
      return Left(ServerFailure(error: error));
    }
  }

  @override
  Future<Either<Failure, List<AddressModel>>> searchAddress({
    required String query,
  }) async {
    try {
      Response response = await remoteData.searchAddress(query);
      List<dynamic> dynamicList = response.data;
      List<AddressModel> addresses = dynamicList
          .map((e) => AddressModel.fromJson(e))
          .toList();

      return Right(addresses);
    } on ServerException catch (error) {
      return Left(ServerFailure(error: error));
    }
  }
}
