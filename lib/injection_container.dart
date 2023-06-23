import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:vikram/features/data/remote_data_source/api_remote_data_source_impl.dart';
import 'package:vikram/features/data/repositories/api_repository_impl.dart';
import 'package:vikram/features/domain/usecases/register_usecase.dart';
import 'package:vikram/features/presentation/cubit/credentials/cubit/credential_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //bloc
  sl.registerFactory<CredentialCubit>(
      () => CredentialCubit(registerUseCase: sl.call()));

  //use cases
  sl.registerLazySingleton<RegisterUsecase>(
      () => RegisterUsecase(apiRepository: sl.call()));

  //repository
  sl.registerLazySingleton<APIRepositoryImpl>(
      () => APIRepositoryImpl(remoteDataSource: sl.call()));

  //remote data source
  sl.registerLazySingleton<APIRemoteDataSourceImpl>(
      () => APIRemoteDataSourceImpl(sl.call()));

  //external
  final http.Client client = http.Client();
  sl.registerLazySingleton(() => client);
}
