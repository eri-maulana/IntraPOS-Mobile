import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intrapos_mobile/app/presentation/add_product_order/add_product_order_screen.dart';
import 'package:intrapos_mobile/app/presentation/checkout/checkout_screen.dart';
import 'package:intrapos_mobile/app/presentation/input_order/input_order_notifier.dart';
import 'package:intrapos_mobile/core/helper/dialog_helper.dart';
import 'package:intrapos_mobile/core/helper/global_helper.dart';
import 'package:intrapos_mobile/core/widget/app_widget.dart';

class InputOrderScreen extends AppWidget<InputOrderNotifier, void, void> {
  @override
  AppBar? appBarBuild(BuildContext context) {
    return AppBar(
      title: Text('Buat Order'),
      actions: [
        IconButton(
            onPressed: () => _onPressCustomer(context),
            icon: Icon(Icons.person))
      ],
    );
  }

  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Produk dipesan',
                  style: GlobalHelper.getTextTheme(context,
                          appTextStyle: AppTextStyle.TITLE_LARGE)
                      ?.copyWith(
                          color: GlobalHelper.getColorScheme(context).primary),
                ),
              ),
              IconButton.outlined(
                  onPressed: () {}, icon: Icon(Icons.qr_code_scanner)),
              Padding(padding: EdgeInsets.all(5)),
              IconButton.filled(
                  onPressed: () => _onPressAddProduct(context),
                  icon: Icon(Icons.add)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => SizedBox(
              height: 5,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return _itemOrderLayout(context);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.maxFinite,
            child: FilledButton(onPressed: () => _onPressCheckout(context), child: Text('Checkout')),
          )
        ],
      ),
    ));
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

  _onPressCustomer(BuildContext context) {
    DialogHelper.showBottomSheetDialog(
        context: context,
        title: 'Pembeli',
        content: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  label: Text('Nama'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                  label: Text('Jenis Kelamin'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                  label: Text('Catatan'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                  label: Text('Email'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                  label: Text('No. Telpon'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                  label: Text('Tanggal Lahir'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.maxFinite,
              child: FilledButton(
                onPressed: () {},
                child: Text('Simpan'),
              ),
            ),
          ],
        ));
  }

  _onPressAddProduct(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddProductOrderScreen(),
        ));
    notifier.init();
  }

  _onPressCheckout(BuildContext context) async {
     await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutScreen(),
        ));
        notifier.init();
  }
}
