import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/action_pill.dart';
import '../../../core/state/gym_state_providers.dart';
import '../models/product_model.dart';

class MarketplaceScreen extends ConsumerWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(marketplaceProvider);

    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('STORE & C2C GEAR', style: AppTypography.tagUppercase.copyWith(fontSize: 9)),
            Text('MARKETPLACE', style: AppTypography.headlineEditorialSm),
          ],
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, idx) {
          final prod = products[idx];
          return _buildProductCard(context, prod);
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, MarketplaceProduct prod) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.carbonSurface1,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.hairline),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Header with Badge
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(prod.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: prod.sellerType == SellerType.gymOfficial
                        ? AppColors.volt
                        : AppColors.carbonSurface2.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    prod.sellerType == SellerType.gymOfficial ? 'UFFICIALE CLUB' : 'ANNUNCIO MEMBRO',
                    style: AppTypography.tagUppercase.copyWith(
                      color: prod.sellerType == SellerType.gymOfficial ? AppColors.onVolt : AppColors.textPrimary,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.obsidianCore.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: AppColors.hairline),
                  ),
                  child: Text(
                    '€${prod.priceEur.toStringAsFixed(0)}',
                    style: AppTypography.metricNumeralMd.copyWith(color: AppColors.volt, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),

          // Details Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(prod.category.toUpperCase(), style: AppTypography.tagUppercase.copyWith(color: AppColors.textSecondary, fontSize: 9)),
                const SizedBox(height: 4),
                Text(prod.title.toUpperCase(), style: AppTypography.headlineEditorialSm.copyWith(fontSize: 16)),
                const SizedBox(height: 4),
                Text(prod.sizeOrVariant, style: AppTypography.bodyCompact.copyWith(color: AppColors.volt)),
                const SizedBox(height: 8),
                Text(prod.description, style: AppTypography.bodyDefault.copyWith(color: AppColors.textSecondary)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Venditore: ${prod.sellerName}', style: AppTypography.bodyCompact),
                    Text('Stato: ${prod.condition}', style: AppTypography.bodyCompact),
                  ],
                ),
                const SizedBox(height: 16),
                ActionPill(
                  label: prod.sellerType == SellerType.gymOfficial ? 'Acquista Prodotto' : 'Contatta Venditore',
                  icon: prod.sellerType == SellerType.gymOfficial ? Icons.shopping_bag_outlined : Icons.chat_bubble_outline,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: AppColors.carbonSurface1,
                        title: Text('DETTAGLIO ORDINE', style: AppTypography.headlineEditorialSm.copyWith(color: AppColors.volt)),
                        content: Text(
                          'Acquisto per "${prod.title}" (€${prod.priceEur.toStringAsFixed(0)}).\n\nIl gateway pagamenti server-side convalida la transazione in sicurezza.',
                          style: AppTypography.bodyDefault,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: Text('CONFERMA ORDINE', style: AppTypography.tagUppercase.copyWith(color: AppColors.volt)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
