

import 'package:dio/dio.dart';
import '../helpers/shared_pref_helper.dart';

class DioFactory {
  static Dio? dio;

  static Dio getDio() {
    if (dio != null) return dio!;

    dio = Dio();

    // ================== BASE OPTIONS ==================
    dio!.options = BaseOptions(
      baseUrl: "https://dummyjson.com", // 👈 غيريها
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );
    print("BASE URL => ${dio!.options.baseUrl}");

    // ================== INTERCEPTORS ==================
    dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          /// 🧠 إضافة التوكن أوتوماتيك
          final token = await SharedPrefHelper.getToken();

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          /// 🧠 اللغة
          options.headers["Accept-Language"] = "ar";

          return handler.next(options);
        },

        onError: (error, handler) async {
          /// ❌ لو التوكن انتهى (مثلاً 401)
          if (error.response?.statusCode == 401) {
            await SharedPrefHelper.removeToken();
          }

          return handler.next(error);
        },
      ),
    );

    return dio!;
  }
}


