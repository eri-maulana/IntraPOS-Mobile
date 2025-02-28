import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:intrapos_mobile/app/data/repositoty/auth_repository.dart';
import 'package:intrapos_mobile/app/data/repositoty/order_repository.dart';
import 'package:intrapos_mobile/app/data/repositoty/payment_method_repository.dart';
import 'package:intrapos_mobile/app/data/repositoty/product_repository.dart';
import 'package:intrapos_mobile/app/data/repositoty/setting_repository.dart';
import 'package:intrapos_mobile/app/data/source/auth_api_service.dart';
import 'package:intrapos_mobile/app/data/source/order_api_service.dart';
import 'package:intrapos_mobile/app/data/source/payment_method_api_service.dart';
import 'package:intrapos_mobile/app/data/source/product_api_service.dart';
import 'package:intrapos_mobile/app/data/source/setting_api_service.dart';
import 'package:intrapos_mobile/app/domain/entity/order.dart';
import 'package:intrapos_mobile/app/domain/entity/product.dart';
import 'package:intrapos_mobile/app/domain/repository/auth_repository.dart';
import 'package:intrapos_mobile/app/domain/repository/order_repository.dart';
import 'package:intrapos_mobile/app/domain/repository/payment_method_repository.dart';
import 'package:intrapos_mobile/app/domain/repository/product_repository.dart';
import 'package:intrapos_mobile/app/domain/repository/setting_repository.dart';
import 'package:intrapos_mobile/app/domain/usecase/auth_login.dart';
import 'package:intrapos_mobile/app/domain/usecase/order_get_all.dart';
import 'package:intrapos_mobile/app/domain/usecase/order_get_by_id.dart';
import 'package:intrapos_mobile/app/domain/usecase/order_get_today.dart';
import 'package:intrapos_mobile/app/domain/usecase/order_send.dart';
import 'package:intrapos_mobile/app/domain/usecase/payment_method_get_all.dart';
import 'package:intrapos_mobile/app/domain/usecase/product_get_all.dart';
import 'package:intrapos_mobile/app/domain/usecase/product_get_by_barcode.dart';
import 'package:intrapos_mobile/app/domain/usecase/setting_get.dart';
import 'package:intrapos_mobile/app/presentation/add_product_order/add_product_order_notifier.dart';
import 'package:intrapos_mobile/app/presentation/checkout/checkout_notifier.dart';
import 'package:intrapos_mobile/app/presentation/detail_order/detail_order_notifier.dart';
import 'package:intrapos_mobile/app/presentation/home/home_notifier.dart';
import 'package:intrapos_mobile/app/presentation/input_order/input_order_notifier.dart';
import 'package:intrapos_mobile/app/presentation/login/login_notifier.dart';
import 'package:intrapos_mobile/app/presentation/order/order_notifier.dart';
import 'package:intrapos_mobile/app/presentation/print/print_notifier.dart';
import 'package:intrapos_mobile/app/presentation/product/product_notifier.dart';
import 'package:intrapos_mobile/app/presentation/profil/profil_notifier.dart';
import 'package:intrapos_mobile/core/network/app_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final sl = GetIt.instance;

void initDependency() {
  //dio
  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      compact: false));
  dio.interceptors.add(AppInterceptor());

  sl.registerSingleton<Dio>(dio);

  //api service
  sl.registerSingleton<AuthApiService>(AuthApiService(sl()));
  sl.registerSingleton<OrderApiService>(OrderApiService(sl()));
  sl.registerSingleton<ProductApiService>(ProductApiService(sl()));
  sl.registerSingleton<PaymentMethodApiService>(PaymentMethodApiService(sl()));
  sl.registerSingleton<SettingApiService>(SettingApiService(sl()));

  //repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));
  sl.registerSingleton<OrderRepository>(OrderRepositoryImpl(sl()));
  sl.registerSingleton<ProductRepository>(ProductRepositoryImpl(sl()));
  sl.registerSingleton<PaymentMethodRepository>(
      PaymentMethodRepositoryImpl(sl()));
  sl.registerSingleton<SettingRepository>(SettingRepositoryImpl(sl()));

  //use case
  sl.registerSingleton<AuthLoginUseCase>(AuthLoginUseCase(sl()));
  sl.registerSingleton<OrderGetTodayUseCase>(OrderGetTodayUseCase(sl()));
  sl.registerSingleton<OrderSendUseCase>(OrderSendUseCase(sl()));
  sl.registerSingleton<OrderGetAllUseCase>(OrderGetAllUseCase(sl()));
  sl.registerSingleton<ProductGetAllUseCase>(ProductGetAllUseCase(sl()));
  sl.registerSingleton<ProductGetByBarcodeUseCase>(
      ProductGetByBarcodeUseCase(sl()));
  sl.registerSingleton<PaymentMethodGetAllUseCase>(
      PaymentMethodGetAllUseCase(sl()));
  sl.registerSingleton<SettingGetUseCase>(SettingGetUseCase(sl()));
  sl.registerSingleton<OrderGetByIdUseCase>(OrderGetByIdUseCase(sl()));

  //presentation
  sl.registerFactoryParam<LoginNotifier, void, void>(
    (param1, param2) => LoginNotifier(sl()),
  );
  sl.registerFactoryParam<HomeNotifier, void, void>(
    (param1, param2) => HomeNotifier(sl()),
  );
  sl.registerFactoryParam<OrderNotifier, void, void>(
    (param1, param2) => OrderNotifier(sl()),
  );

  sl.registerFactoryParam<InputOrderNotifier, void, void>(
    (param1, param2) => InputOrderNotifier(sl()),
  );
  sl.registerFactoryParam<AddProductOrderNotifier, List<ProductItemOrderEntity>,
      void>(
    (param1, param2) => AddProductOrderNotifier(param1, sl()),
  );
  sl.registerFactoryParam<CheckoutNotifier, OrderEntity, void>(
    (param1, param2) => CheckoutNotifier(param1, sl(), sl()),
  );
  sl.registerFactoryParam<PrintNotifier, void, void>(
    (param1, param2) => PrintNotifier(),
  );
  sl.registerFactoryParam<ProfilNotifier, void, void>(
    (param1, param2) => ProfilNotifier(),
  );
  sl.registerFactoryParam<ProductNotifier, void, void>(
    (param1, param2) => ProductNotifier(sl()),
  );
  sl.registerFactoryParam<DetailOrderNotifier, int, void>(
    (param1, param2) => DetailOrderNotifier(param1, sl(), sl()),
  );
}
