import 'package:flutter_project_app/features/users/domain/repositories/firebase_repository.dart';

class IsSignInUseCase {
  final FirebaseRepository repository;

  IsSignInUseCase(this.repository);

  Future<bool> call() async => await repository.isSignIn();
}
