import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/telemetry_tile.dart';
import '../../../core/components/section_header.dart';
import '../../../core/components/action_pill.dart';
import '../../../core/state/gym_state_providers.dart';
import '../models/user_profile_model.dart';
import 'onboarding_biometric_modal.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showThemeSelector(BuildContext context, WidgetRef ref, AppThemeMode currentMode) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.carbonSurface1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('SELEZIONA TEMA APP', style: AppTypography.headlineEditorialSm.copyWith(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppColors.textSecondary),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Theme Option 1: OBSIDIAN
              _buildThemeOption(
                ctx,
                ref,
                title: 'KINETIC OBSIDIAN (Default)',
                subtitle: 'Sfondo Nero #0A0A0B · Accent Volt Lime #D4FF00',
                mode: AppThemeMode.obsidian,
                isSelected: currentMode == AppThemeMode.obsidian,
                previewBg: const Color(0xFF0A0A0B),
                previewAccent: const Color(0xFFD4FF00),
              ),
              const SizedBox(height: 12),

              // Theme Option 2: COOL
              _buildThemeOption(
                ctx,
                ref,
                title: 'COOL (Tema Chiaro Grigio & Espresso)',
                subtitle: 'Sfondo #CBCBCB · Card #E5E5E5 · Accent #5A5A5A · Testo #2E1B0E',
                mode: AppThemeMode.cool,
                isSelected: currentMode == AppThemeMode.cool,
                previewBg: const Color(0xFFCBCBCB),
                previewAccent: const Color(0xFF5A5A5A),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String subtitle,
    required AppThemeMode mode,
    required bool isSelected,
    required Color previewBg,
    required Color previewAccent,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(themeModeProvider.notifier).setTheme(mode);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: context.cardBg2,
            content: Text(
              'Tema impostato su ${mode == AppThemeMode.cool ? "COOL (#CBCBCB)" : "OBSIDIAN"}',
              style: AppTypography.bodyDefault.copyWith(color: context.isCoolTheme ? AppColors.coolAccent : AppColors.volt),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? context.cardBg2 : context.cardBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? (context.isCoolTheme ? AppColors.coolAccent : AppColors.volt) : context.hairlineColor,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: previewBg,
                shape: BoxShape.circle,
                border: Border.all(color: context.hairlineColor),
              ),
              child: Center(
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: previewAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.bodyDefault.copyWith(fontWeight: FontWeight.bold, fontSize: 15, color: context.textPrimaryColor)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTypography.bodyCompact.copyWith(fontSize: 12, color: context.textSecondaryColor)),
                ],
              ),
            ),
            if (isSelected) Icon(Icons.check_circle, color: context.isCoolTheme ? AppColors.coolAccent : AppColors.volt, size: 22),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAvatar(BuildContext context, WidgetRef ref) async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
      if (image != null) {
        ref.read(userProfileProvider.notifier).setAvatarPath(image.path);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Foto profilo aggiornata dalla galleria!')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Impossibile aprire la galleria: $e')),
        );
      }
    }
  }

  Widget _buildAvatarWidget(String? avatarPath) {
    if (avatarPath != null && avatarPath.isNotEmpty && File(avatarPath).existsSync()) {
      return Image.file(File(avatarPath), fit: BoxFit.cover, width: 72, height: 72);
    }
    return Image.network(
      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop',
      fit: BoxFit.cover,
      width: 72,
      height: 72,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    final userProfile = ref.watch(userProfileProvider);
    final activeColor = context.isCoolTheme ? AppColors.coolAccent : AppColors.volt;

    return Scaffold(
      backgroundColor: context.appBg,
      appBar: AppBar(
        backgroundColor: context.appBg.withValues(alpha: 0.92),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ATLETA & ACCOUNT', style: AppTypography.tagUppercase.copyWith(fontSize: 11, color: context.textSecondaryColor)),
            Text('PROFILO', style: AppTypography.headlineEditorialSm.copyWith(fontSize: 18, color: context.textPrimaryColor)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card with Interactive Avatar Picker
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.cardBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.hairlineColor),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _pickAvatar(context, ref),
                    child: Stack(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: activeColor, width: 2),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: _buildAvatarWidget(userProfile.avatarPath),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: activeColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: context.appBg, width: 1.5),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 14,
                              color: context.isCoolTheme ? AppColors.coolOnAccent : AppColors.onVolt,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(userProfile.fullName, style: AppTypography.headlineEditorialSm.copyWith(fontSize: 20, color: context.textPrimaryColor)),
                            const SizedBox(width: 8),
                            Icon(Icons.verified, size: 18, color: activeColor),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(userProfile.membershipLevel, style: AppTypography.tagUppercase.copyWith(color: activeColor, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text('ID: #KN-88291 · KINETIC CLUB MILANO', style: AppTypography.bodyDefault.copyWith(color: context.textSecondaryColor)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Dati Biometrici Atleta & Ricalcolo Carichi
            SectionHeader(
              title: 'Profilo Biometrico & Carichi',
              actionLabel: 'Modifica Dati',
              onAction: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const OnboardingBiometricModal(),
                );
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TelemetryTile(
                    label: 'PESO & ALTEZZA',
                    value: '${userProfile.weightKg.toStringAsFixed(0)}kg / ${userProfile.heightCm}cm',
                    statusText: '${userProfile.age} ANNI',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TelemetryTile(
                    label: 'LIVELLO & IMC',
                    value: userProfile.fitnessLevel.toUpperCase(),
                    statusText: 'IMC ${userProfile.bmi.toStringAsFixed(1)} · ${userProfile.bmiCategory}',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Membership & Credits Telemetry
            SectionHeader(title: 'Stato Abbonamento'),
            Row(
              children: [
                const Expanded(
                  child: TelemetryTile(
                    label: 'ABBONAMENTO',
                    value: 'ATTIVO',
                    statusText: 'Scadenza: 31 Dic 2026',
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: TelemetryTile(
                    label: 'CREDITI CORSI',
                    value: '18',
                    unit: 'DISPONIBILI',
                    statusText: 'Pacchetto Black Unlimited',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Settings & Actions Menu
            SectionHeader(title: 'Impostazioni & Tema'),
            _buildMenuItem(
              context,
              Icons.palette_outlined,
              'Tema dell App',
              currentThemeMode == AppThemeMode.cool ? 'Tema Attivo: COOL (#CBCBCB)' : 'Tema Attivo: KINETIC OBSIDIAN (Default)',
              onTap: () => _showThemeSelector(context, ref, currentThemeMode),
            ),
            _buildMenuItem(context, Icons.credit_card_outlined, 'Metodi di Pagamento & Fatture', 'Mastercard •••• 4242'),
            _buildMenuItem(context, Icons.calendar_today_outlined, 'Storico Prenotazioni & Presenze', '24 sessioni chiuse'),
            _buildMenuItem(context, Icons.fitness_center_outlined, 'Storico Massimali & Progressioni', 'Ultimo log: Oggi'),
            _buildMenuItem(context, Icons.privacy_tip_outlined, 'Privacy & Consensi GDPR', 'Verificato EU'),
            _buildMenuItem(context, Icons.support_agent_outlined, 'Assistenza Reception & Regolamento', 'Aperto fino alle 22:30'),
            const SizedBox(height: 28),

            ActionPill(
              label: 'Rinnova Abbonamento / Ricarica Crediti',
              icon: Icons.bolt,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Apertura modulo rinnovo rapido...')),
                );
              },
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, String subtitle, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: context.cardBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.hairlineColor),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: context.isCoolTheme ? AppColors.coolAccent : AppColors.volt),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.bodyDefault.copyWith(fontWeight: FontWeight.w600, fontSize: 16, color: context.textPrimaryColor)),
                  const SizedBox(height: 3),
                  Text(subtitle, style: AppTypography.bodyCompact.copyWith(fontSize: 14, color: context.textSecondaryColor)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 20, color: context.textSecondaryColor),
          ],
        ),
      ),
    );
  }
}
