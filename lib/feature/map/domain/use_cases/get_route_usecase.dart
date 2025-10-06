import 'package:dartz/dartz.dart';
import 'package:task2/feature/map/data/model/route_path_model.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../repositories/map_repository.dart';

class GetRouteUsecase
    extends BaseUseCase<RoutePathModel, Map<String, dynamic>> {
  MapRepository repository;
  GetRouteUsecase({required this.repository});

  @override
  Future<Either<Failure, RoutePathModel>> call(params) async {
    return await repository.getPathRoute(
      start: params['start'],
      end: params['end'],
    );
  }
}
