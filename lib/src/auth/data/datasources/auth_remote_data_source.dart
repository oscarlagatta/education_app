import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/auth/data/models/user_model.dart';

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
