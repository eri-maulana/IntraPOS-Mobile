import 'package:intrapos_mobile/app/domain/entity/setting.dart';
import 'package:intrapos_mobile/app/domain/repository/setting_repository.dart';
import 'package:intrapos_mobile/core/network/data_state.dart';
import 'package:intrapos_mobile/core/use_case/app_use_case.dart';

class SettingGetUseCase
    extends AppUseCase<Future<DataState<SettingEntity>>, void> {
  final SettingRepository _settingRepository;

  SettingGetUseCase(this._settingRepository);

  @override
  Future<DataState<SettingEntity>> call({void param}) {
    return _settingRepository.get();
  }
}
