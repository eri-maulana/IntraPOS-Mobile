import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:intrapos_mobile/app/data/repositoty/auth_repository.dart';
import 'package:intrapos_mobile/app/data/source/auth_api_service.dart';
import 'package:intrapos_mobile/app/domain/repository/auth_repository.dart';
import 'package:intrapos_mobile/app/domain/usecase/auth_login.dart';
import 'package:intrapos_mobile/app/presentation/add_product_order/add_product_order_notifier.dart';
import 'package:intrapos_mobile/app/presentation/checkout/checkout_notifier.dart';
import 'package:intrapos_mobile/app/presentation/home/home_notifier.dart';
import 'package:intrapos_mobile/app/presentation/input_order/input_order_notifier.dart';
import 'package:intrapos_mobile/app/presentation/login/login_notifier.dart';
import 'package:intrapos_mobile/app/presentation/order/order_notifier.dart';
import 'package:intrapos_mobile/app/presentation/print/print_notifier.dart';
import 'package:intrapos_mobile/app/presentation/profil/profil_notifier.dart';
import 'package:intrapos_mobile/core/network/app_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final sl = GetIt.instance;

void initDependency() {
  // dio
  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      compact: false));
  dio.interceptors.add(AppInterceptor());

  sl.registerSingleton<Dio>(dio);

  // api service
  sl.registerSingleton<AuthApiService>(AuthApiService(sl()));

  // repository
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl(sl()));

  // use case
  sl.registerSingleton<AuthLoginUseCase>(AuthLoginUseCase(sl()));

  // presentation
  sl.registerFactoryParam<LoginNotifier, void, void>(
    (param1, param2) => LoginNotifier(sl()),
  );
  sl.registerFactoryParam<HomeNotifier, void, void>(
    (param1, param2) => HomeNotifier(),
  );
  sl.registerFactoryParam<OrderNotifier, void, void>(
    (param1, param2) => OrderNotifier(),
  );
  sl.registerFactoryParam<InputOrderNotifier, void, void>(
    (param1, param2) => InputOrderNotifier(),
  );
  sl.registerFactoryParam<AddProductOrderNotifier, void, void>(
    (param1, param2) => AddProductOrderNotifier(),
  );
  sl.registerFactoryParam<CheckoutNotifier, void, void>(
    (param1, param2) => CheckoutNotifier(),
  );
  sl.registerFactoryParam<PrintNotifier, void, void>(
    (param1, param2) => PrintNotifier(),
  );
  sl.registerFactoryParam<ProfilNotifier, void, void>(
    (param1, param2) => ProfilNotifier(),
  );
}
