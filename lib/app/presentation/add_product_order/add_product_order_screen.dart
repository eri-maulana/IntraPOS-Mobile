import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intrapos_mobile/app/presentation/add_product_order/add_product_order_notifier.dart';
import 'package:intrapos_mobile/core/helper/global_helper.dart';
import 'package:intrapos_mobile/core/widget/app_widget.dart';

class AddProductOrderScreen
    extends AppWidget<AddProductOrderNotifier, void, void> {
  @override
  AppBar? appBarBuild(BuildContext context) {
    return AppBar(
      title: Text('Tambah Produk'),
    );
  }

  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        label: Text('Cari Produk'),
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton.outlined(
                  onPressed: () {},
                  icon: Icon(Icons.qr_code_scanner),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                
                separatorBuilder: (context, index) => SizedBox(
                  height: 5,
                ),
                itemCount: 15,
                itemBuilder: (context, index) {
                  return _itemOrderLayout(context);
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '2 Item',
                    style: GlobalHelper.getTextTheme(context,
                        appTextStyle: AppTextStyle.TITLE_MEDIUM),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                FilledButton(
                  onPressed: () {},
                  child: Text('Simpan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _itemOrderLayout(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(
                color: GlobalHelper.getColorScheme(context).shadow, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  'nama_produk',
                  style: GlobalHelper.getTextTheme(context,
                      appTextStyle: AppTextStyle.LABEL_LARGE),
                )),
                Text(
                  'Rp. 1.000.000',
                  style: GlobalHelper.getTextTheme(context,
                          appTextStyle: AppTextStyle.BODY_LARGE)
                      ?.copyWith(
                          color: GlobalHelper.getColorScheme(context).primary,
                          fontWeight: FontWeight.bold),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Stok: 50',
                  style: GlobalHelper.getTextTheme(context,
                      appTextStyle: AppTextStyle.LABEL_MEDIUM),
                ),
                Expanded(child: SizedBox()),
                IconButton.outlined(onPressed: () {}, icon: Icon(Icons.remove)),
                SizedBox(
                  width: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: GlobalHelper.getColorScheme(context).shadow,
                          width: 0.5),
                      borderRadius: BorderRadius.circular(4)),
                  child: Text(
                    '1',
                    style: GlobalHelper.getTextTheme(context,
                        appTextStyle: AppTextStyle.BODY_LARGE),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton.outlined(onPressed: () {}, icon: Icon(Icons.add)),
              ],
            )
          ],
        ));
  }
}
