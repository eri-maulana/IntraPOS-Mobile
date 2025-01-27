import 'package:intrapos_mobile/app/domain/entity/order.dart';
import 'package:intrapos_mobile/app/domain/entity/product.dart';
import 'package:intrapos_mobile/app/presentation/checkout/checkout_notifier.dart';
import 'package:intrapos_mobile/app/presentation/detail_order/detail_order_notifier.dart';
import 'package:intrapos_mobile/app/presentation/print/print_screen.dart';
import 'package:intrapos_mobile/core/helper/date_time_helper.dart';
import 'package:intrapos_mobile/core/helper/global_helper.dart';
import 'package:intrapos_mobile/core/helper/number_helper.dart';
import 'package:intrapos_mobile/core/widget/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailOrderScreen extends AppWidget<DetailOrderNotifier, int, void> {
  DetailOrderScreen({required super.param1});

  @override
  AppBar? appBarBuild(BuildContext context) {
    return AppBar(
      title: Text('Detail Pesanan'),
    );
  }

  @override
  Widget bodyBuild(BuildContext context) {
    return ListView(
      children: [
        _customerLayout(context),
        Container(
          height: 3,
          margin: EdgeInsets.symmetric(vertical: 3),
          color: GlobalHelper.getColorScheme(context).outline,
        ),
        _productLayout(context),
        Container(
          height: 3,
          margin: EdgeInsets.symmetric(vertical: 3),
          color: GlobalHelper.getColorScheme(context).outline,
        ),
        _paymentLayout(context),
        SizedBox(
          height: 30,
        ),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(10),
          child: FilledButton(
              onPressed: () => _onPressPrint(context),
              child: Text('Print Invoice')),
        )
      ],
    );
  }

  _customerLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              Text(': ${notifier.order!.name}')
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon((notifier.order!.gender == CheckoutNotifier.MALE)
                  ? Icons.male
                  : Icons.female),
              SizedBox(
                width: 3,
              ),
              Text(
                  ': ${(notifier.order!.gender == CheckoutNotifier.MALE) ? 'Laki-laki' : 'Perempuan'}')
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
              Text(': ${notifier.order!.email ?? '-'}')
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
              Text(': ${notifier.order!.phone ?? '-'}')
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
              Text(
                  ': ${(notifier.order!.birthday != null) ? DateTimeHelper.formatDateTimeFromString(dateTimeString: notifier.order!.birthday!, format: 'dd MMM yyyy') : '-'}')
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text('Catatan : '),
          ),
          Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Expanded(child: Text('${notifier.order!.note ?? '-'}'))
            ],
          )
        ],
      ),
    );
  }

  _productLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Produk Dipesan',
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
            itemCount: notifier.order!.items.length,
            itemBuilder: (context, index) {
              final item = notifier.order!.items[index];
              return _itemProductLayout(context, item);
            },
          )
        ],
      ),
    );
  }

  _paymentLayout(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ringkasan pembayaran',
            style: GlobalHelper.getTextTheme(context,
                appTextStyle: AppTextStyle.TITLE_MEDIUM),
          ),
          SizedBox(
            height: 10,
          ),
          _itemPaymentLayout(context, 'Metode pembayaran',
              notifier.order!.paymentMethod!.name),
          SizedBox(
            height: 5,
          ),
          _itemPaymentLayout(context, 'Total bayar',
              NumberHelper.formatIdr(notifier.order!.totalPrice ?? 0)),
          SizedBox(
            height: 5,
          ),
          _itemPaymentLayout(context, 'Nominal bayar',
              NumberHelper.formatIdr(notifier.order!.paidAmount ?? 0)),
          SizedBox(
            height: 5,
          ),
          _itemPaymentLayout(context, 'Kembalian',
              NumberHelper.formatIdr(notifier.order!.changeAmount ?? 0)),
        ],
      ),
    );
  }

  _itemProductLayout(BuildContext context, ProductItemOrderEntity item) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
            color: GlobalHelper.getColorScheme(context).outline, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: GlobalHelper.getTextTheme(context,
                appTextStyle: AppTextStyle.BODY_MEDIUM),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '${item.quantity} x ${NumberHelper.formatIdr(item.price)}',
              style: GlobalHelper.getTextTheme(context,
                      appTextStyle: AppTextStyle.BODY_LARGE)
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  _itemPaymentLayout(BuildContext context, String label, String value) {
    return Row(
      children: [
        Expanded(
            child: Text(
          label,
          style: GlobalHelper.getTextTheme(context,
              appTextStyle: AppTextStyle.BODY_MEDIUM),
        )),
        Text(
          value,
          style: GlobalHelper.getTextTheme(context,
                  appTextStyle: AppTextStyle.BODY_LARGE)
              ?.copyWith(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  _onPressPrint(BuildContext context) {
    notifier.print();
  }
}
