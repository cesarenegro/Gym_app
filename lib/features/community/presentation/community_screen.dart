import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/state/gym_state_providers.dart';
import '../models/community_models.dart';
import 'moderation_sheet.dart';

class CommunityScreen extends ConsumerWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(communityProvider);

    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('COMMUNITY & FEED', style: AppTypography.tagUppercase.copyWith(fontSize: 11)),
            Text('KINETIC FEED', style: AppTypography.headlineEditorialSm.copyWith(fontSize: 18)),
          ],
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: posts.length,
        separatorBuilder: (_, __) => const SizedBox(height: 18),
        itemBuilder: (context, idx) {
          final post = posts[idx];
          return _buildPostCard(context, ref, post);
        },
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, WidgetRef ref, CommunityPost post) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.carbonSurface1,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.hairline),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(post.authorAvatar),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.authorName, style: AppTypography.headlineEditorialSm.copyWith(fontSize: 16)),
                      Text(
                        post.authorRole.toUpperCase(),
                        style: AppTypography.tagUppercase.copyWith(
                          color: post.authorRole.contains('Coach') ? AppColors.volt : AppColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz, color: AppColors.textSecondary),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (ctx) => ModerationSheet(
                      contentId: post.id,
                      authorName: post.authorName,
                      onReportSubmitted: () {
                        ref.read(communityProvider.notifier).reportPost(post.id, 'Segnalato da utente');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Post segnalato al team di moderazione.')),
                        );
                      },
                      onUserBlocked: () {
                        ref.read(communityProvider.notifier).hidePost(post.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Hai bloccato ${post.authorName}. Non vedrai più i suoi post.')),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Content Text
          Text(post.content, style: AppTypography.bodyDefault.copyWith(fontSize: 16, height: 1.4)),
          const SizedBox(height: 14),

          // Optional Image
          if (post.imageUrl != null) ...[
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(post.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 14),
          ],

          // Footer Actions (Like, Comment, Time)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => ref.read(communityProvider.notifier).toggleLike(post.id),
                    child: Row(
                      children: [
                        Icon(
                          post.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                          size: 20,
                          color: post.isLikedByMe ? AppColors.volt : AppColors.textSecondary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${post.likesCount}',
                          style: AppTypography.tagUppercase.copyWith(
                            color: post.isLikedByMe ? AppColors.volt : AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Row(
                    children: [
                      const Icon(Icons.chat_bubble_outline, size: 18, color: AppColors.textSecondary),
                      const SizedBox(width: 6),
                      Text('${post.commentsCount}', style: AppTypography.tagUppercase.copyWith(color: AppColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              Text(
                '2 ORE FA',
                style: AppTypography.tagUppercase.copyWith(color: AppColors.textSecondary, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
