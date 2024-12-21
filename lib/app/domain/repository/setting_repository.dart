import 'package:intrapos_mobile/app/domain/entity/setting.dart';
import 'package:intrapos_mobile/core/network/data_state.dart';

abstract class SettingRepository {
  Future<DataState<SettingEntity>> get();
}
