import 'package:flutter_project_app/features/users/domain/repositories/user_firebase_repository.dart';

class SignOutUseCase {
  final UserFirebaseRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }
}
