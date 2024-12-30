import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intrapos_mobile/app/presentation/checkout/checkout_notifier.dart';
import 'package:intrapos_mobile/core/helper/global_helper.dart';
import 'package:intrapos_mobile/core/widget/app_widget.dart';

class CheckoutScreen extends AppWidget<CheckoutNotifier, void, void> {
  @override
  AppBar? appBarBuild(BuildContext context) {
    return AppBar(
      title: Text('Checkout'),
    );
  }

  @override
  Widget bodyBuild(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          _customerLayout(context),
          SizedBox(
            height: 20,
          ),
          _productLayout(context),
          SizedBox(
            height: 20,
          ),
          _paymentLayout(context),
          SizedBox(
            height: 20,
          ),
          Container(
              width: double.maxFinite,
              child: FilledButton(onPressed: () {}, child: Text('Kirim')))
        ],
      ),
    ));
  }

  _customerLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: GlobalHelper.getColorScheme(context).shadow, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            'Pembeli',
            style: GlobalHelper.getTextTheme(context,
                appTextStyle: AppTextStyle.TITLE_MEDIUM),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(Icons.person),
              SizedBox(
                width: 3,
              ),
              Text(': nama_customer'),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(Icons.male),
              SizedBox(
                width: 3,
              ),
              Text(': laki - laki'),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(Icons.email),
              SizedBox(
                width: 3,
              ),
              Text(': customer@gmail.com'),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(
                width: 3,
              ),
              Text(': +628xxxxxxxxx'),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon(Icons.event),
              SizedBox(
                width: 3,
              ),
              Text(': 11 Mei 2001'),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text('Catatan: '),
          ),
          Row(
            children: [
              SizedBox(
                width: 35,
              ),
              Expanded(
                child: Text('Catatan Pembeli'),
              ),
            ],
          )
        ],
      ),
    );
  }

  _productLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: GlobalHelper.getColorScheme(context).shadow, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            'Produk dipesan',
            style: GlobalHelper.getTextTheme(context,
                appTextStyle: AppTextStyle.TITLE_MEDIUM),
          ),
          SizedBox(
            height: 10,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 0.5,
                  color: GlobalHelper.getColorScheme(context).shadow,
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            itemCount: 5,
            itemBuilder: (context, index) {
              return _itemProductLayout(context);
            },
          )
        ],
      ),
    );
  }

  _paymentLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: GlobalHelper.getColorScheme(context).shadow, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            'Pembayaran',
            style: GlobalHelper.getTextTheme(context,
                appTextStyle: AppTextStyle.TITLE_MEDIUM),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            decoration: InputDecoration(
                label: Text('Total Pembayaran'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            decoration: InputDecoration(
                label: Text('Metode Pembayaran'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            decoration: InputDecoration(
                label: Text('Nominal Bayar'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            decoration: InputDecoration(
                label: Text('Kembalian'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  _itemProductLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'nama_produk',
          style: GlobalHelper.getTextTheme(context,
              appTextStyle: AppTextStyle.TITLE_MEDIUM),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '1 x Rp. 50.000',
            style: GlobalHelper.getTextTheme(context,
                    appTextStyle: AppTextStyle.BODY_LARGE)
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
