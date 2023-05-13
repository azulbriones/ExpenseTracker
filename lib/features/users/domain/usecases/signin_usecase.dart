import 'package:flutter_project_app/features/users/domain/repositories/firebase_repository.dart';

class SignInUseCase {
  final FirebaseRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(String email, String password) async {
    return repository.signIn(email, password);
  }
}
