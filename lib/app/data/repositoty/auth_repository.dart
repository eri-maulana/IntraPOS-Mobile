import 'package:intrapos_mobile/app/data/model/auth.dart';
import 'package:intrapos_mobile/app/data/source/auth_api_service.dart';
import 'package:intrapos_mobile/app/domain/entity/auth.dart';
import 'package:intrapos_mobile/app/domain/repository/auth_repository.dart';
import 'package:intrapos_mobile/core/constant/constant.dart';
import 'package:intrapos_mobile/core/helper/shared_preferences.dart';
import 'package:intrapos_mobile/core/network/data_state.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl(this._authApiService);
  @override
  Future<DataState> login(AuthEntity param) {
    return handleResponse(() => _authApiService.login(body: param.toJson()),
        (json) async {
      final authModel = AuthModel.fromJson(json);
      await SharedPreferencesHelper.setString(
          PREF_AUTH, '${authModel.tokenType} ${authModel.accessToken}');
      await SharedPreferencesHelper.setInt(PREF_ID, authModel.user.id);
      await SharedPreferencesHelper.setString(PREF_NAME, authModel.user.name);
      await SharedPreferencesHelper.setString(PREF_EMAIL, authModel.user.email);
      return null;
    });
  }
}
