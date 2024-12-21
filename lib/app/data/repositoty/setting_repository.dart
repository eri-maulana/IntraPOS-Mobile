import 'package:intrapos_mobile/app/data/source/setting_api_service.dart';
import 'package:intrapos_mobile/app/domain/entity/setting.dart';
import 'package:intrapos_mobile/app/domain/repository/setting_repository.dart';
import 'package:intrapos_mobile/core/network/data_state.dart';

class SettingRepositoryImpl extends SettingRepository {
  final SettingApiService _settingApiService;

  SettingRepositoryImpl(this._settingApiService);
  @override
  Future<DataState<SettingEntity>> get() {
    return handleResponse(
        () => _settingApiService.get(), (json) => SettingEntity.fromJson(json));
  }
}
