import 'package:taskmanagenet/features/domain/entities/user_info_entity.dart';

abstract class ICreateUserUseCase {
  Future<void> call(UserEntity user, String? imagePath);
}
