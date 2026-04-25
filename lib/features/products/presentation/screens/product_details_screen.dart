import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prof_7oda_app/features/cart/presentation/cart_cubit.dart';
import 'package:prof_7oda_app/features/products/presentation/cubit/favorites_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/entities/product_entity.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  // 🔥 حالة مؤقتة للزرار (هل المنتج اتضاف؟)
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          // 🔥 الصورة + back + favorite
          Stack(
            children: [
              Image.network(
                widget.product.image,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              Positioned(
                top: 40,
                left: 16,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

              Positioned(
                top: 40,
                right: 16,
                child: BlocBuilder<FavoritesCubit, Set<int>>(
                  builder: (context, favorites) {

                    // ❤️ هل المنتج مفضل؟
                    final isFav = favorites.contains(widget.product.id);

                    return GestureDetector(
                      onTap: () {
                        context.read<FavoritesCubit>().toggleFavorite(widget.product.id);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          // 📄 التفاصيل
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 📛 اسم المنتج
                  Text(
                    widget.product.title,
                    style: AppTextStyles.heading,
                  ),

                  const SizedBox(height: 8),

                  // ⭐ التقييم
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(widget.product.rating.toString()),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 💰 السعر
                  Text(
                    "\$${widget.product.price}",
                    style: AppTextStyles.heading.copyWith(
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 📝 وصف المنتج
                  const Text(
                    "This is a high quality product with amazing features. Perfect for daily use.",
                    style: AppTextStyles.body,
                  ),

                  const Spacer(),

                  // 🛒 زرار احترافي (مش بدائي)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300), // ✨ انيميشن ناعم
                    width: double.infinity,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        isAdded ? Colors.green : AppColors.primary, // 🔥 يتغير اللون
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      onPressed: () {

                        // 🔥 1. نضيف المنتج للكارت
                        context.read<CartCubit>().addToCart(widget.product);

                        // 🔥 2. نغير حالة الزرار فورًا (Optimistic UI)
                        setState(() {
                          isAdded = true;
                        });

                        // 🔥 3. SnackBar احترافي
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: const Text("Added to cart"),
                        //     behavior: SnackBarBehavior.floating, // يطفو مش تحت خالص
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(12),
                        //     ),
                        //   ),
                        // );

                        // 🔥 4. يرجع لحالته بعد ثانيتين (زي Amazon)
                        Future.delayed(const Duration(seconds: 2), () {
                          setState(() {
                            isAdded = false;
                          });
                        });
                      },

                      // 🔥 محتوى الزرار بيتغير
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Icon(
                            isAdded ? Icons.check : Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),

                          const SizedBox(width: 8),

                          Text(
                            isAdded ? "Added" : "Add to Cart",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}