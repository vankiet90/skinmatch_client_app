import 'package:flutter/material.dart';
import '../models/recommendation_product_model.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _isAddedToCart = false;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hình ảnh sản phẩm
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.product.productImageUrl ?? "",
              height: 187,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported),
            ),
          ),
          const SizedBox(height: 8),

          // Tên sản phẩm
          Text(
            widget.product.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontUtils.semiBoldSM,
              color: ColorUtils.neutral[950],
            ),
          ),
          const SizedBox(height: 4),

          // Giá sản phẩm
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${widget.product.currency}${widget.product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontUtils.boldSM,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Thành phần chính
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: ColorUtils.neutral[200]!),
              ),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                childrenPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                iconColor: Colors.black,
                collapsedIconColor: Colors.black,
                title: Text(
                  localization.keyIngredients,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                children: [
                  Text(widget.product.components),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Hướng dẫn sử dụng
          Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: ColorUtils.neutral[200]!),
              ),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                childrenPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                iconColor: Colors.black,
                collapsedIconColor: Colors.black,
                title: Text(
                  localization.howToUse,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                children: [
                  Text(widget.product.instructions),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Button thêm vào giỏ hàng
          if (_isAddedToCart)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) _quantity--;
                    });
                  },
                  icon:
                      const Icon(Icons.remove, color: ColorUtils.primaryColor),
                ),
                Text('$_quantity', style: const TextStyle(fontSize: 16)),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: const Icon(Icons.add, color: ColorUtils.primaryColor),
                ),
              ],
            )
          else
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isAddedToCart = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtils.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  localization.addToCart,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontUtils.semiBoldSM,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
