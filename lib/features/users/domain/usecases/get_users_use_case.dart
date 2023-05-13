import 'package:flutter_project_app/features/users/domain/entities/users_entity.dart';
import 'package:flutter_project_app/features/users/domain/repositories/firebase_repository.dart';

class GetUsersUseCase {
  final FirebaseRepository repository;

  GetUsersUseCase({required this.repository});

  Stream<List<UsersEntity>> call() => repository.getUsers();
}
