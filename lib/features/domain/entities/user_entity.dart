import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? email;
  final String? phone;
  final String? vbot;
  final String? agentBot;
  final String? password;

  const UserEntity(
      {this.name,
      this.email,
      this.phone,
      this.vbot,
      this.agentBot,
      this.password});

  @override
  List<Object?> get props => [name, email, phone, vbot, agentBot, password];
}
