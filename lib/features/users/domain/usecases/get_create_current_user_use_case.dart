import 'package:flutter_project_app/features/users/domain/entities/user_entity.dart';
import 'package:flutter_project_app/features/users/domain/repositories/user_firebase_repository.dart';

class GetCreateCurrentUserUseCase {
  final UserFirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    //print("hoa");
    return repository.getCreateCurrentUser(user);
  }
}
