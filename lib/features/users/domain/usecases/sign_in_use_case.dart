import 'package:flutter_project_app/features/users/domain/entities/user_entity.dart';
import 'package:flutter_project_app/features/users/domain/repositories/user_firebase_repository.dart';

class SignInUseCase {
  final UserFirebaseRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.signIn(user);
  }
}
