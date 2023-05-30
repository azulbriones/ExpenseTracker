import 'package:flutter_project_app/features/users/domain/repositories/user_firebase_repository.dart';

class IsSignInUseCase {
  final UserFirebaseRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isSignIn();
  }
}
