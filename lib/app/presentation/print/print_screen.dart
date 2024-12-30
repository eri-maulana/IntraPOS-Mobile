import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intrapos_mobile/app/presentation/print/print_notifier.dart';
import 'package:intrapos_mobile/core/helper/global_helper.dart';
import 'package:intrapos_mobile/core/widget/app_widget.dart';

class PrintScreen extends AppWidget<PrintNotifier, void, void> {
  @override
  AppBar? appBarBuild(BuildContext context) {
    return AppBar(
      title: Text('Cetak Invoice'),
    );
  }

  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        width: double.maxFinite,
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Icon(
              Icons.check_circle,
              size: 75,
              color: Colors.green,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Order Berhasil Disimpan',
              style: GlobalHelper.getTextTheme(context,
                  appTextStyle: AppTextStyle.HEADLINE_SMALL),
            ),
            SizedBox(
              height: 20,
            ),
            _deviceLayout(
              context,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  _deviceLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
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
          separatorBuilder: (context, index) => SizedBox(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return _itemDeviceLayout(context);
          },
        ),
      ],
    );
  }

  _itemDeviceLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: GlobalHelper.getColorScheme(context).shadow,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.bluetooth_connected),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Nama'), Text('Alamat Perangkat')],
              ),
            ),
            SizedBox(
              width: 5,
            ),
            FilledButton(
              onPressed: () {},
              child: Text('Print'),
            ),
          ],
        ),
      ),
    );
  }
}
