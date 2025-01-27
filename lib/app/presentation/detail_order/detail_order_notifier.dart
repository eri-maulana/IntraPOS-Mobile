import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:intrapos_mobile/app/domain/entity/order.dart';
import 'package:intrapos_mobile/app/domain/entity/setting.dart';
import 'package:intrapos_mobile/app/domain/usecase/order_get_by_id.dart';
import 'package:intrapos_mobile/app/domain/usecase/setting_get.dart';
import 'package:intrapos_mobile/core/constant/constant.dart';
import 'package:intrapos_mobile/core/helper/date_time_helper.dart';
import 'package:intrapos_mobile/core/helper/number_helper.dart';
import 'package:intrapos_mobile/core/helper/shared_preferences.dart';
import 'package:intrapos_mobile/core/provider/app_provider.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class DetailOrderNotifier extends AppProvider {
  final int _id;
  final OrderGetByIdUseCase _orderGetByIdUseCase;
  final SettingGetUseCase _settingGetUseCase;

  DetailOrderNotifier(
      this._id, this._orderGetByIdUseCase, this._settingGetUseCase) {
    init();
  }

  OrderEntity? _order;

  OrderEntity? get order => _order;

  @override
  init() async {
    await _getOrder();
  }

  _getOrder() async {
    showLoading();

    final response = await _orderGetByIdUseCase(param: _id);
    if (response.success) {
      _order = response.data!;
    } else {
      errorMessage = response.message;
    }

    hideLoading();
  }

  Future<SettingEntity?> _getSetting() async {
    final response = await _settingGetUseCase();
    if (response.success) {
      return response.data!;
    } else {
      snackBarMessage = response.message;
      return null;
    }
  }

  print() async {
    showLoading();

    final printerSave =
        await SharedPreferencesHelper.getString(PREF_PRINTER) ?? '';

    if (printerSave.isNotEmpty) {
      SettingEntity? setting = await _getSetting();
      if (setting != null) {
        await PrintBluetoothThermal.connect(macPrinterAddress: printerSave);
        bool connectStatus = await PrintBluetoothThermal.connectionStatus;
        if (connectStatus) {
          List<int> ticket = await _generateInvoice(setting);
          final result = await PrintBluetoothThermal.writeBytes(ticket);
          if (result) {
            snackBarMessage = 'Sukses print invoice';
          } else {
            snackBarMessage = 'Gagal print invoice';
          }
        } else {
          snackBarMessage = 'Tidak dapat terhubung pada bluetooth yang dipilih';
        }
      }
    } else {
      snackBarMessage = 'Anda belum menyiapkan printer';
    }

    hideLoading();
  }

  Future<List<int>> _generateInvoice(SettingEntity setting) async {
    final date = DateTimeHelper.formatDateTime(
        dateTime: DateTime.now(), format: 'dd MMM yyyy HH:mm:ss');
    final Generator ticket =
        Generator(PaperSize.mm58, await CapabilityProfile.load());
    List<int> bytes = [];
    if (setting.shop?.isNotEmpty ?? false)
      bytes += ticket.text(setting.shop ?? '-',
          styles: PosStyles(
              align: PosAlign.center,
              height: PosTextSize.size2,
              width: PosTextSize.size2));
    if (setting.address?.isNotEmpty ?? false)
      bytes += ticket.text(setting.address ?? '-',
          styles: PosStyles(align: PosAlign.center));

    if (setting.phone?.isNotEmpty ?? false)
      bytes += ticket.text('Telp : ${setting.phone ?? '-'}',
          styles: PosStyles(align: PosAlign.center));
    bytes += ticket.feed(1);
    bytes += ticket.text(date, styles: PosStyles(align: PosAlign.center));

    bytes += ticket.feed(2);
    bytes += ticket.hr(ch: '=');
    bytes += ticket.text('Produk yang dipesan',
        styles: PosStyles(align: PosAlign.center));
    bytes += ticket.hr(ch: '=');
    _order!.items.forEach(
      (element) {
        bytes += ticket.text('${element.name}', styles: PosStyles());
        bytes += ticket.row([
          PosColumn(text: '', width: 4),
          PosColumn(
              text: NumberHelper.formatIdr(element.price),
              width: 3,
              styles: PosStyles(align: PosAlign.right)),
          PosColumn(
              text: '${element.quantity}',
              width: 2,
              styles: PosStyles(align: PosAlign.right)),
          PosColumn(
              text: NumberHelper.formatIdr(element.price * element.quantity),
              width: 3,
              styles: PosStyles(align: PosAlign.right)),
        ]);
      },
    );

    bytes += ticket.hr();
    bytes += ticket.row([
      PosColumn(
          text: 'TOTAL', width: 6, styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: NumberHelper.formatIdr(_order!.totalPrice!),
          width: 6,
          styles: PosStyles(align: PosAlign.right)),
    ]);
    bytes += ticket.hr(ch: '=');
    bytes += ticket.row([
      PosColumn(
          text: 'Nominal Bayar',
          width: 6,
          styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: NumberHelper.formatIdr(_order!.paidAmount!),
          width: 6,
          styles: PosStyles(align: PosAlign.right)),
    ]);

    bytes += ticket.row([
      PosColumn(
          text: 'Kembalian',
          width: 6,
          styles: PosStyles(align: PosAlign.right)),
      PosColumn(
          text: NumberHelper.formatIdr(_order!.changeAmount!),
          width: 6,
          styles: PosStyles(align: PosAlign.right)),
    ]);

    bytes += ticket.feed(2);
    bytes +=
        ticket.text('Terima kasih', styles: PosStyles(align: PosAlign.center));
    ticket.feed(2);
    return bytes;
  }
}
