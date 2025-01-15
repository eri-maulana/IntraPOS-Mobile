import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intrapos_mobile/app/domain/entity/order.dart';
import 'package:intrapos_mobile/app/domain/entity/product.dart';
import 'package:intrapos_mobile/app/presentation/checkout/checkout_notifier.dart';
import 'package:intrapos_mobile/app/presentation/print/print_screen.dart';
import 'package:intrapos_mobile/core/helper/date_time_helper.dart';
import 'package:intrapos_mobile/core/helper/global_helper.dart';
import 'package:intrapos_mobile/core/helper/number_helper.dart';
import 'package:intrapos_mobile/core/widget/app_widget.dart';

class CheckoutScreen extends AppWidget<CheckoutNotifier, OrderEntity, void> {
  CheckoutScreen({required super.param1});
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
              child: FilledButton(
                  onPressed: () => _onPressSend(context), child: Text('Kirim')))
        ],
      ),
    ));
  }

  @override
  checkVariable(BuildContext context) async {
    if (notifier.isSuccess) {
      await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PrintScreen(
              param1: notifier.order,
            ),
          ));
      Navigator.pop(context, true);
    }
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
              Text(': ${notifier.order.name}'),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Icon((notifier.order.gender == CheckoutNotifier.MALE)
                  ? Icons.male
                  : Icons.female),
              SizedBox(
                width: 3,
              ),
              Text(':  ${(notifier.order.gender == CheckoutNotifier.MALE) ? 'Laki-laki' : 'Perempuan'}'),
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
              Text(': ${notifier.order.email ?? '-'}'),
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
              Text(': ${notifier.order.phone ?? '-'}'),
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
              Text(': ${(notifier.order.birthday != null) ? DateTimeHelper.formatDateTimeFromString(dateTimeString: notifier.order.birthday!, format: 'dd MMM yyyy') : '-'}'),
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
                child: Text('${notifier.order.note ?? '-'}'),
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
          borderRadius: BorderRadius.circular(10)),
      child: Column(
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
                )
              ],
            ),
            itemCount: notifier.order.items.length,
            itemBuilder: (context, index) {
              final item = notifier.order.items[index];
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
      decoration: BoxDecoration(
          border: Border.all(
              color: GlobalHelper.getColorScheme(context).shadow, width: 0.5),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            'Pembayaran',
            style: GlobalHelper.getTextTheme(context,
                appTextStyle: AppTextStyle.TITLE_MEDIUM),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: notifier.totalController,
            keyboardType: TextInputType.number,
            readOnly: true,
            decoration: InputDecoration(
                label: Text('Total Pembayaran'), border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 10,
          ),
          DropdownMenu<int>(
            expandedInsets: EdgeInsets.symmetric(horizontal: 1),
            label: Text('Metode Pembayaran'),
            controller: notifier.methodController,
            dropdownMenuEntries: notifier.listDropdownPaymentMethod,
            initialSelection: notifier.initialPaymentMethod,
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: notifier.amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                label: Text('Nominal bayar'), border: OutlineInputBorder()),
            onSubmitted: (value) => _updateChangeAmount(),
            onTapOutside: (event) => _updateChangeAmount(),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: notifier.changeController,
            keyboardType: TextInputType.number,
            readOnly: true,
            decoration: InputDecoration(
                label: Text('Kembalian'), border: OutlineInputBorder()),
          ),
        ],
      ),
    );
  }

  _itemProductLayout(BuildContext context, ProductItemOrderEntity item) {
    return Column(
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
    );
  }

  _updateChangeAmount() {
    notifier.updateChangeAmount();
  }

  _onPressSend(BuildContext context) {
    notifier.send();
  }
}
