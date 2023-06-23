import '../../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {final String? name,
      final String? email,
      final String? phone,
      final String? vbot,
      final String? agentBot,
      final String? password})
      : super(
            name: name,
            email: email,
            phone: phone,
            password: password,
            vbot: vbot,
            agentBot: agentBot);

  Map<String, dynamic> toDocument() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "vbot": vbot,
      "agentBot": agentBot,
      "password": password
    };
  }
}
