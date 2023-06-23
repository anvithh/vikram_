import '../entities/user_entity.dart';
import '../repositories/api_repository.dart';
import 'package:http/http.dart' as http;

class RegisterUsecase {

  final APIRepository apiRepository;

  RegisterUsecase({required this.apiRepository}); 

  Future<http.Response> register(Map<String, dynamic> body) {
    return apiRepository.register(body);
  }

}