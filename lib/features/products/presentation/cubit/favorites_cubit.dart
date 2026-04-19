import 'package:flutter_bloc/flutter_bloc.dart';

// 🎯 Cubit مسؤول عن إدارة المنتجات المفضلة (Favorites)
// بنخزنهم في Set<int> (يعني مجموعة IDs للمنتجات)
class FavoritesCubit extends Cubit<Set<int>> {

  // 🔥 Constructor
  // بنبدأ بـ state فاضية {} يعني مفيش منتجات مفضلة
  FavoritesCubit() : super({});

  // ❤️ دالة لإضافة أو إزالة المنتج من المفضلة (Toggle)
  void toggleFavorite(int productId) {

    // 🧠 بنعمل نسخة من الحالة الحالية (state)
    // مهم جدًا عشان منعدلش على الأصل مباشرة (immutability)
    final current = Set<int>.from(state);

    // 🔍 لو المنتج موجود بالفعل في المفضلة
    if (current.contains(productId)) {

      // ❌ نشيله (unfavorite)
      current.remove(productId);

    } else {

      // ✅ نضيفه (favorite)
      current.add(productId);
    }

    // 🚀 نحدث الحالة الجديدة → UI هيعمل rebuild تلقائي
    emit(current);
  }

  // 🔎 دالة بتسأل: هل المنتج ده مفضل؟
  bool isFavorite(int id) {

    // بترجع true لو موجود في الـ Set
    return state.contains(id);
  }
}