enum PostType { standard, achievement, announcement, trainerTip }

enum ModerationStatus { published, pending, reported, hidden }

class CommunityPost {
  final String id;
  final String authorName;
  final String authorAvatar;
  final String authorRole; // 'Membro', 'Head Coach', 'Club Ufficiale'
  final String content;
  final String? imageUrl;
  final String? videoUrl;
  final DateTime createdAt;
  final int likesCount;
  final int commentsCount;
  final bool isLikedByMe;
  final PostType type;
  final ModerationStatus moderationStatus;

  const CommunityPost({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.authorRole,
    required this.content,
    this.imageUrl,
    this.videoUrl,
    required this.createdAt,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isLikedByMe = false,
    this.type = PostType.standard,
    this.moderationStatus = ModerationStatus.published,
  });

  CommunityPost copyWith({
    int? likesCount,
    bool? isLikedByMe,
    ModerationStatus? moderationStatus,
  }) {
    return CommunityPost(
      id: id,
      authorName: authorName,
      authorAvatar: authorAvatar,
      authorRole: authorRole,
      content: content,
      imageUrl: imageUrl,
      videoUrl: videoUrl,
      createdAt: createdAt,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount,
      isLikedByMe: isLikedByMe ?? this.isLikedByMe,
      type: type,
      moderationStatus: moderationStatus ?? this.moderationStatus,
    );
  }
}
