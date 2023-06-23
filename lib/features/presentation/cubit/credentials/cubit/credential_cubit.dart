import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vikram/features/domain/usecases/register_usecase.dart';
import 'package:http/http.dart' as http;

part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final RegisterUsecase registerUseCase;
  CredentialCubit({required this.registerUseCase}) : super(CredentialInitial());

  Future<void> submitRegister({required Map<String, dynamic> body}) async {
    try {

      await registerUseCase.register(body);

    } on SocketException catch(_) {
      emit(CredentialFailure());
    } 
  }
}
