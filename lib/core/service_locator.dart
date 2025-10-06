import 'package:get_it/get_it.dart';
import 'package:task2/feature/map/data/repositories/dynamic_form_repository_imp.dart';
import 'package:task2/feature/map/domain/repositories/map_repository.dart';
import 'package:task2/feature/map/domain/use_cases/get_route_usecase.dart';

import '../feature/map/data/data_sources/map_api_provider.dart';

final GetIt locator = GetIt.instance;

Future<void> serviceLocator() async {
  locator.registerSingleton<MapRemoteData>(MapRemoteData());
  //repository

  locator.registerSingleton<MapRepository>(
    MapRepositoryImpl(remoteData: locator()),
  );

  //usecase
  locator.registerSingleton<GetRouteUsecase>(
    GetRouteUsecase(repository: locator()),
  );
}
