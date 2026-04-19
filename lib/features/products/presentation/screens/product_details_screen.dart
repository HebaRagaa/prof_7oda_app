

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prof_7oda_app/features/products/presentation/cubit/favorites_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../domain/entities/product_entity.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // 🔥 الصورة + back + favorite
          Stack(
            children: [
              Image.network(
                product.image,
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
                    final isFav = favorites.contains(product.id);

                    return GestureDetector(
                      onTap: () {
                        context.read<FavoritesCubit>().toggleFavorite(product.id);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.9),                        child: Icon(
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
                  // 📛 الاسم
                  Text(
                    product.title,
                    style: AppTextStyles.heading,
                  ),

                  const SizedBox(height: 8),

                  // ⭐ rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(product.rating.toString()),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 💰 السعر
                  Text(
                    "\$${product.price}",
                    style: AppTextStyles.heading.copyWith(
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 📝 description (مؤقت)
                  const Text(
                    "This is a high quality product with amazing features. Perfect for daily use.",
                    style: AppTextStyles.body,
                  ),

                  const Spacer(),

                  // 🛒 زرار
                  CustomButton(
                    text: "Add To Cart",
                    onPressed: () {},
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


