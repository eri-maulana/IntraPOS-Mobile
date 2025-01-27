import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intrapos_mobile/app/domain/entity/order.dart';
import 'package:intrapos_mobile/app/presentation/print/print_notifier.dart';
import 'package:intrapos_mobile/core/helper/global_helper.dart';
import 'package:intrapos_mobile/core/widget/app_widget.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class PrintScreen extends AppWidget<PrintNotifier, void, void> {
  @override
  AppBar? appBarBuild(BuildContext context) {
    return AppBar(
      title: Text('Setting Printer'),
    );
  }

  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: EdgeInsets.all(10),
      width: double.maxFinite,
      child: Column(
        children: [_deviceLayout(context)],
      ),
    ));
  }

  _deviceLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daftar Printer',
          style: GlobalHelper.getTextTheme(context,
              appTextStyle: AppTextStyle.TITLE_MEDIUM),
        ),
        SizedBox(
          height: 10,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(
            height: 5,
          ),
          itemCount: notifier.listBluetooth.length,
          itemBuilder: (context, index) {
            final item = notifier.listBluetooth[index];
            return _itemDeviceLayout(context, item);
          },
        )
      ],
    );
  }

  _itemDeviceLayout(BuildContext context, BluetoothInfo item) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
              color: GlobalHelper.getColorScheme(context).shadow, width: 0.5),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(Icons.bluetooth_connected),
          SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(item.name), Text(item.macAdress)],
          )),
          SizedBox(
            width: 5,
          ),
          (item.macAdress == notifier.printerSave)
              ? Text(
                  'Dipilih',
                  style: GlobalHelper.getTextTheme(context,
                      appTextStyle: AppTextStyle.BODY_MEDIUM),
                )
              : FilledButton(
                  onPressed: () => _onPressPrint(item), child: Text('Print'))
        ],
      ),
    );
  }

  _onPressPrint(BluetoothInfo item) {
    notifier.save(item.macAdress);
  }
}
