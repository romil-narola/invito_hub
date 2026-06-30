import 'package:equatable/equatable.dart';

// Mock User class since we removed Firebase
class MockUser extends Equatable {
  final String uid;
  final String phoneNumber;
  final String? displayName;

  const MockUser({
    required this.uid,
    required this.phoneNumber,
    this.displayName,
  });

  @override
  List<Object?> get props => [uid, phoneNumber, displayName];
}

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthOtpSent extends AuthState {
  final String verificationId;

  const AuthOtpSent(this.verificationId);

  @override
  List<Object?> get props => [verificationId];
}

class AuthAuthenticated extends AuthState {
  final MockUser user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
