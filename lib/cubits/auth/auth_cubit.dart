import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  void login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(email, password);
      emit(AuthLoggedIn(user));
    } catch (e) {
      emit(AuthError('Failed to login: $e'));
    }
  }

  void logout() async {
    await _authRepository.logout();
    emit(AuthLoggedOut());
  }

  void checkLoginStatus() async {
    emit(AuthLoading());
    final isLoggedIn = await _authRepository.isLoggedIn();
    if (isLoggedIn) {
      final user = await _authRepository.getCurrentUser();
      emit(AuthLoggedIn(user));
    } else {
      emit(AuthLoggedOut());
    }
  }
}
