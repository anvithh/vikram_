import 'package:vikram/features/data/remote_data_source/api_remote_data_source.dart';
import 'package:vikram/features/domain/entities/user_entity.dart';
import 'package:http/http.dart' as http;

import '../../domain/repositories/api_repository.dart';

class APIRepositoryImpl implements APIRepository {

  final APIRemoteDataSource remoteDataSource ;

  APIRepositoryImpl({required this.remoteDataSource}); 


  @override
  Future<http.Response> register(Map<String, dynamic> body) async => remoteDataSource.register(body);
    // TODO: implement register

    // Future<http.Response> register(Map<String, dynamic> body) async => remoteDataSource.register(body);
    
  
}
