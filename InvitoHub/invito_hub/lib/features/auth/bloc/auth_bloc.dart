import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String? _mockPhoneNumber;

  AuthBloc() : super(AuthInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SignOutEvent>(_onSignOut);
    on<AuthStateChangedEvent>(_onAuthStateChanged);
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      _mockPhoneNumber = event.phoneNumber;

      // Emit OTP sent with a mock verification ID
      emit(const AuthOtpSent('mock-verification-id-12345'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      if (event.otpCode == '123456') {
        // Accept '123456' as valid OTP for testing
        final user = MockUser(
          uid: 'mock-uid-999',
          phoneNumber: _mockPhoneNumber ?? '+1234567890',
        );
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthError("Invalid OTP. For mock testing, use 123456"));
      }
    } catch (e) {
      emit(AuthError("Error: ${e.toString()}"));
    }
  }

  Future<void> _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      final user = const MockUser(
        uid: 'mock-google-uid-777',
        phoneNumber: '',
        displayName: 'Google User',
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError("Google Sign-In failed: ${e.toString()}"));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError("Sign-Out failed: ${e.toString()}"));
    }
  }

  void _onAuthStateChanged(
    AuthStateChangedEvent event,
    Emitter<AuthState> emit,
  ) {
    if (event.isAuthenticated) {
      // If we had local storage, we'd restore the user here. For mock, we just stay unauthenticated
      // or we can emit a default user.
      // For now we'll do nothing as we rely on the direct VerifyOtpEvent or SignInWithGoogleEvent
    } else {
      emit(AuthUnauthenticated());
    }
  }
}
