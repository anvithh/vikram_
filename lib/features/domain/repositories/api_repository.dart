import '../entities/user_entity.dart';
import 'package:http/http.dart' as http;

abstract class APIRepository {

  // Future<void> register(UserEntity user);
  Future<http.Response> register(Map<String, dynamic> body);

}