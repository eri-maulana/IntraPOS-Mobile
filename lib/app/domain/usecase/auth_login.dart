import 'package:intrapos_mobile/app/domain/entity/auth.dart';
import 'package:intrapos_mobile/app/domain/repository/auth_repository.dart';
import 'package:intrapos_mobile/core/network/data_state.dart';
import 'package:intrapos_mobile/core/use_case/app_use_case.dart';

class AuthLoginUseCase extends AppUseCase<Future<DataState>, AuthEntity> {
  final AuthRepository _authRepository;

  AuthLoginUseCase(this._authRepository);
  @override
  Future<DataState> call({AuthEntity? param}) {
    return _authRepository.login(param!);
  }
}