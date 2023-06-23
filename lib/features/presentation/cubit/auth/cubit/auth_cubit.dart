import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:vikram/features/domain/usecases/register_usecase.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> appStarted() async {
    
  }
}
