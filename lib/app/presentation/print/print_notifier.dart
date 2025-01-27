import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:intrapos_mobile/app/domain/entity/order.dart';
import 'package:intrapos_mobile/app/domain/entity/setting.dart';
import 'package:intrapos_mobile/app/domain/usecase/setting_get.dart';
import 'package:intrapos_mobile/core/constant/constant.dart';
import 'package:intrapos_mobile/core/helper/date_time_helper.dart';
import 'package:intrapos_mobile/core/helper/number_helper.dart';
import 'package:intrapos_mobile/core/helper/shared_preferences.dart';
import 'package:intrapos_mobile/core/provider/app_provider.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class PrintNotifier extends AppProvider {

  PrintNotifier() {
    init();
  }

  String _printerSave = '';

  List<BluetoothInfo> _listBluetooth = [];

  String get printerSave => _printerSave;

  List<BluetoothInfo> get listBluetooth => _listBluetooth;

  @override
  init() async {
    await _getPrinterSave();
    await _getBluetoothStatus();
    if (errorMessage.isEmpty) await _getBluetoothPaired();
  }

  _getPrinterSave() async {
    showLoading();
    _printerSave = await SharedPreferencesHelper.getString(PREF_PRINTER) ?? '';
    hideLoading();
  }


  _getBluetoothStatus() async {
    showLoading();
    if (!await PrintBluetoothThermal.isPermissionBluetoothGranted) {
      errorMessage = 'Harap berikan perizinan bluetooth';
    } else if (!await PrintBluetoothThermal.bluetoothEnabled) {
      errorMessage = 'Harap aktifkan bluetooth';
    }
    hideLoading();
  }

  _getBluetoothPaired() async {
    showLoading();
    _listBluetooth = await PrintBluetoothThermal.pairedBluetooths;
    hideLoading();
  }

  save(String param) async {
    await SharedPreferencesHelper.setString(PREF_PRINTER, param);
    _getPrinterSave();
  }

  
}