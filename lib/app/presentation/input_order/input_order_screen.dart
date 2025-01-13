import 'package:flutter/material.dart';
import 'package:flutter/src/material/app_bar.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intrapos_mobile/app/domain/entity/product.dart';
import 'package:intrapos_mobile/app/presentation/add_product_order/add_product_order_screen.dart';
import 'package:intrapos_mobile/app/presentation/checkout/checkout_screen.dart';
import 'package:intrapos_mobile/app/presentation/input_order/input_order_notifier.dart';
import 'package:intrapos_mobile/core/helper/date_time_helper.dart';
import 'package:intrapos_mobile/core/helper/dialog_helper.dart';
import 'package:intrapos_mobile/core/helper/global_helper.dart';
import 'package:intrapos_mobile/core/helper/number_helper.dart';
import 'package:intrapos_mobile/core/widget/app_widget.dart';

class InputOrderScreen extends AppWidget<InputOrderNotifier, void, void> {
  @override
  AppBar? appBarBuild(BuildContext context) {
    return AppBar(
      title: Text('Buat Pesanan'),
      actions: [
        IconButton(
            onPressed: () => _showDialogCustomer(context),
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
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => SizedBox(
              height: 5,
            ),
            itemCount: notifier.listOrderItem.length,
            itemBuilder: (context, index) {
              final item = notifier.listOrderItem[index];
              return _itemOrderLayout(context, item);
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.maxFinite,
            child: FilledButton(
                onPressed: () => _onPressCheckout(context),
                child: Text('Checkout')),
          )
        ],
      ),
    ));
  }

  @override
  checkVariable(BuildContext context) {
    if (notifier.isShowCustomer || notifier.errorCustomer.isNotEmpty) {
      notifier.isShowCustomer = false;
      _showDialogCustomer(context);
    }
  }

  _itemOrderLayout(BuildContext context, ProductItemOrderEntity item) {
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
                  item.name,
                  style: GlobalHelper.getTextTheme(context,
                      appTextStyle: AppTextStyle.LABEL_LARGE),
                )),
                Text(
                  NumberHelper.formatIdr(item.price),
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
                  'Stok: ${item.stock}',
                  style: GlobalHelper.getTextTheme(context,
                      appTextStyle: AppTextStyle.LABEL_MEDIUM),
                ),
                Expanded(child: SizedBox()),
                IconButton.outlined(
                  onPressed: () => _onPressRemoveQuantity(item),
                  icon: Icon(Icons.remove)),
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
                    item.quantity.toString(),
                    style: GlobalHelper.getTextTheme(context,
                        appTextStyle: AppTextStyle.BODY_LARGE),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton.outlined(
                  onPressed: (item.stock != null &&
                          item.stock! > 0 &&
                          item.stock! > item.quantity)
                      ? () => _onPressAddQuantity(item)
                      : null,
                  icon: Icon(Icons.add))
              ],
            )
          ],
        ));
  }

  _showDialogCustomer(BuildContext context) {
    DialogHelper.showBottomSheetDialog(
        context: context,
        title: 'Pembeli',
        content: Column(
          children: [
            TextField(
              controller: notifier.nameController,
              decoration: InputDecoration(
                  label: Text('Nama'),
                  border: OutlineInputBorder(),
                  errorText: notifier.errorCustomer[InputOrderNotifier.NAME]),
            ),
            SizedBox(
              height: 10,
            ),
            DropdownMenu<String>(
              expandedInsets: EdgeInsets.symmetric(horizontal: 1),
              label: Text('Jenis Kelamin'),
              dropdownMenuEntries: notifier.genderListDropdown,
              controller: notifier.genderController,
              errorText: notifier.errorCustomer[InputOrderNotifier.GENDER],
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: notifier.notesController,
              decoration: InputDecoration(
                  label: Text('Catatan'), border: OutlineInputBorder()),
              maxLines: null,
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: notifier.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  label: Text('Email'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: notifier.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  label: Text('No. Telp'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              readOnly: true,
              onTap: () => _onPressBirthDay(context),
              controller: notifier.birthdayController,
              decoration: InputDecoration(
                  label: Text('Tanggal Lahir'), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                width: double.maxFinite,
                child: FilledButton(
                    onPressed: () => _onPressSaveCustomer(context),
                    child: Text('Simpan')))
          ],
        ));
  }

  _onPressBirthDay(BuildContext context) async {
    DateTime? birthday = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime.now());
    notifier.birthdayController.text =
        DateTimeHelper.formatDateTime(dateTime: birthday, format: 'yyyy-MM-dd');
  }

  _onPressSaveCustomer(BuildContext context) {
    Navigator.pop(context);
    notifier.validateCustomer();
  }

  _onPressAddProduct(BuildContext context) async {
    final List<ProductItemOrderEntity>? items = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddProductOrderScreen(
            param1: notifier.listOrderItem,
          ),
        ));
    if (items != null) notifier.updateItems(items);
  }

  // _onPressBarcode(BuildContext context) {
  //   QrBarCodeScannerDialog().getScannedQrBarCode(
  //       context: context,
  //       onCode: (code) {
  //         notifier.scan(code ?? '');
  //       });
  // }

  _onPressRemoveQuantity(ProductItemOrderEntity item) {
    notifier.updateQuantity(item, item.quantity - 1);
  }

  _onPressAddQuantity(ProductItemOrderEntity item) {
    notifier.updateQuantity(item, item.quantity + 1);
  }

  _onPressCheckout(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckoutScreen(),
        ));
  }
}
