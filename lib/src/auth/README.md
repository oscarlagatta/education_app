# Authentication Feature Development

## Authentication Feature

### Folder Structure
- `src/<feature_name>`
- `src/auth`

## Creating Entities

### Folder Structure And Entity User
- Path: `src/auth/domain/entities`
- Entity file: `src/auth/domain/entities/<entity_name>.dart`
  - Example: `src/auth/domain/entities/user.dart`
  - Inherits from `Equatable`
  - Overrides `toString()`
  - Provides an `empty()` constructor for initializing properties

## Creating Repositories

### Folder Structure And Authentication Repository
- Path: `src/auth/domain/repos`
- Repository file: `src/auth/domain/repos/<name>_repo.dart`
  - Example: `src/auth/domain/repos/auth_repo.dart`
  - Defines an abstract class
  - Declares abstract methods returning `ResultFuture<T>` with named parameters
  - `ResultFuture` is imported from `core/utils/typedefs.dart`
  - Example method: `ResultFuture<LocalUser> signIn({required String email, ...})`

#### Enum for User Updates
- Enum file path: `lib/core/enums/update_user.dart`
  - Defines `UpdateUserAction` enum with fields like `displayName`, `email`, `password`, `bio`, `profilePic`
- Method signature example for updating user:
  ```dart
  ResultFuture<void> updateUser({
    required UpdateUserAction action, 
    dynamic userData,
  });
  ```

## Creating Use Cases

### Folder Structure
- Path: `src/auth/domain/usecases`
- Use case file: `src/auth/domain/usecases/<use_case>.dart`
  - Example: `src/auth/domain/usecases/forgot_password.dart`
- Extends `UseCaseWithParameters` or `UseCaseWithoutParameters`
- Depends on the `AuthRepo` abstract class

#### Use Case Example: Forgot Password
```dart
class ForgotPassword extends UseCaseWithParams<void, String> {
  const ForgotPassword(this._repo);
  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);
}
```

#### Use Case With Parameters: Sign In
```dart
class SignIn extends UseCaseWithParams<LocalUser, SignInParams> {
  const SignIn(this._repo);
  final AuthRepo _repo;

  @override
  ResultFuture<LocalUser> call(SignInParams params) =>
    _repo.signIn(email: params.email, password: params.password);
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});
  
  const SignInParams.empty() : this(email: '', password: '');
  
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
```

## Data Layer

### User Model
- Create `user_model.dart` under `auth/data/models` as a subclass of the User entity
- Implement `Empty` constructor
- Implement `fromMap()` and `toMap()` methods
- Write unit tests for model validation

### Authentication Repository Implementation

- We implement the repository in de data layer, 
- Folder Structure auth/data/repos
- Folder: auth/data/repos/<repo_name>_impl.dart
  - eg. auth_repo_impl.dart
  - we have a remote data source dependency to create
```dart
class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

}
```
- Each method uses try on error catch as follows
```dart

  @override
  ResultFuture<void> forgotPassword(String email) async {
    try {
      await _remoteDataSource.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }
```

- We create the abstraction for the remote data source as follows

```dart
abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> forgotPassword(String email);

  // LocalUserModel is a generic model, not the entity
  // we could use TutorUserModel, StudentUserModel, but
  // LocalUserModel is the generic version. And also
  // because the backend can return any of those, so
  // we use the generic based model, but never the entity.
  // Entity doesn't have toMap(), fromMap(), copyWith(), etc
  Future<LocalUserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  Future<void> updateUser({required UpdateUserAction action, dynamic userData});
}
```

