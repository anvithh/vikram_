import 'package:vikram/features/data/remote_data_source/api_remote_data_source.dart';
// import 'package:vikram/features/domain/entities/user_entity.dart';
import 'package:http/http.dart' as http;

class APIRemoteDataSourceImpl implements APIRemoteDataSource {
  final http.Client client;

  APIRemoteDataSourceImpl(this.client);
  
  @override
  Future<http.Response> register(Map<String, dynamic> body) {
    // TODO: implement register
    throw UnimplementedError();
  }



  // Future<http.Response> register(Map<String, dynamic> body) async {
  //   // TODO: implement register
  //   throw UnimplementedError();
  // }
}
