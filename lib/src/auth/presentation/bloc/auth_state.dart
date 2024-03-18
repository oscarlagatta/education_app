part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

// This state will be the single instance that
// will be used for SigningInState, UpdatingUser, etc.
// so we use one single state for every authentication stuff.
// Every auth process or every authentication event will be
// using the same Auth loading state.

class AuthLoading extends AuthState {
  const AuthLoading();
}

// When user successfully sings in
class SignedIn extends AuthState {
  const SignedIn(this.user);

  final LocalUser user;

  @override
  List<Object> get props => [user];
}

class SignedUp extends AuthState {
  const SignedUp();
}

class ForgotPasswordSent extends AuthState {
  const ForgotPasswordSent();
}

class UserUpdated extends AuthState {
  const UserUpdated();
}

class AuthError extends AuthState {
  const AuthError(this.errorMessage);

  final String errorMessage;

  @override
  List<String> get props => [errorMessage];
}