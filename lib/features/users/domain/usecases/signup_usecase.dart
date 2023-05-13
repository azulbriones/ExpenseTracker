import 'package:flutter_project_app/features/users/domain/repositories/firebase_repository.dart';

class SignUpUseCase {
  final FirebaseRepository repository;

  SignUpUseCase({required this.repository});

  Future<void> call(String email, String password) async {
    return repository.signUp(email, password);
  }
}
