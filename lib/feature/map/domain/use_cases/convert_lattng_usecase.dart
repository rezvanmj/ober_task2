import 'package:dartz/dartz.dart';
import 'package:task2/feature/map/data/model/address_model.dart';

import '../../../../core/exceptions/failure.dart';
import '../../../../core/usecase/base_use_case.dart';
import '../repositories/map_repository.dart';

class ConvertLattngUsecase
    extends BaseUseCase<AddressModel, Map<String, dynamic>> {
  MapRepository repository;
  ConvertLattngUsecase({required this.repository});

  @override
  Future<Either<Failure, AddressModel>> call(params) async {
    return await repository.getAddress(point: params['point']);
  }
}
