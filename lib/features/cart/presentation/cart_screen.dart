import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prof_7oda_app/features/cart/presentation/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔥 AppBar بتاع الصفحة
      appBar: AppBar(
        title: const Text("My Cart"), // عنوان الشاشة
        centerTitle: true, // يخلي العنوان في النص
      ),

      // 🔥 بنسمع لتغيرات الكارت
      body: BlocBuilder<CartCubit, List>(
        builder: (context, cart) {

          // 🟡 لو الكارت فاضي
          if (cart.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // 🟢 يخلي الحجم على قد المحتوى
                children: const [
                  Icon(Icons.shopping_cart_outlined, size: 80),
                  SizedBox(height: 12),
                  Text(
                    "Your cart is empty 🛒",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }
          // 🔥 لو فيه منتجات
          return ListView.separated(
            padding: const EdgeInsets.all(16), // مسافة حوالين الليست

            itemCount: cart.length, // عدد المنتجات

            // 🔥 مسافة بين كل عنصر والتاني
            separatorBuilder: (_, __) => const SizedBox(height: 12),

            itemBuilder: (context, index) {
              final product = cart[index]; // المنتج الحالي

              return Container(
                padding: const EdgeInsets.all(12), // padding داخلي

                // 🔥 تصميم الكارت
                decoration: BoxDecoration(
                  color: Colors.white, // خلفية بيضا
                  borderRadius: BorderRadius.circular(16), // حواف ناعمة
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8, // نعومة الظل
                      color: Colors.black12, // لون خفيف
                      offset: Offset(0, 3), // مكان الظل
                    ),
                  ],
                ),

                child: Row(
                  children: [

                    // 🖼️ صورة المنتج
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12), // تدوير الصورة
                      child: Image.network(
                        product.image,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover, // تغطية كاملة
                      ),
                    ),

                    const SizedBox(width: 12), // مسافة

                    // 📄 الاسم + السعر
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // 🔥 اسم المنتج
                          Text(
                            product.title,
                            maxLines: 1, // سطر واحد بس
                            overflow: TextOverflow.ellipsis, // ... لو طويل
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 6),

                          // 💰 السعر
                          Text(
                            "\$${product.price}",
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 🗑️ زرار الحذف
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),

                      onPressed: () async {

                        // 🔥 نعرض رسالة تأكيد
                        final confirm = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Delete Product"),
                              content: const Text(
                                "Are you sure you want to remove this item?",
                              ),

                              actions: [

                                // ❌ إلغاء
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text("Cancel"),
                                ),

                                // ✅ تأكيد الحذف
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        // 🔥 لو وافق على الحذف
                        if (confirm == true) {
                          context.read<CartCubit>().removeFromCart(product);

                          // 🔔 رسالة تأكيد
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Removed from cart"),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}