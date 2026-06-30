import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;

  const SendOtpEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthEvent {
  final String otpCode;

  const VerifyOtpEvent(this.otpCode);

  @override
  List<Object?> get props => [otpCode];
}

class SignInWithGoogleEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}

class AuthStateChangedEvent extends AuthEvent {
  final bool isAuthenticated;

  const AuthStateChangedEvent(this.isAuthenticated);

  @override
  List<Object?> get props => [isAuthenticated];
}
