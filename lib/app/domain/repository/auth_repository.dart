import 'package:intrapos_mobile/app/domain/entity/auth.dart';
import 'package:intrapos_mobile/core/network/data_state.dart';

abstract class AuthRepository {
  Future<DataState> login(AuthEntity param);
}
