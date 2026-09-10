import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/telemetry_tile.dart';
import '../../../core/components/section_header.dart';
import '../../../core/components/action_pill.dart';
import '../../../core/state/gym_state_providers.dart';

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
                title: 'COOL (Tema Grigio Metallico)',
                subtitle: 'Sfondo #CBCBCB · Accent #5A5A5A · Testi #F2F2F2',
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
            backgroundColor: AppColors.carbonSurface2,
            content: Text(
              'Tema impostato su ${mode == AppThemeMode.cool ? "COOL (#CBCBCB)" : "OBSIDIAN"}',
              style: AppTypography.bodyDefault.copyWith(color: AppColors.volt),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.carbonSurface2 : AppColors.obsidianCore,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isSelected ? AppColors.volt : AppColors.hairline, width: isSelected ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: previewBg,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.hairline),
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
                  Text(title, style: AppTypography.bodyDefault.copyWith(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTypography.bodyCompact.copyWith(fontSize: 12)),
                ],
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle, color: AppColors.volt, size: 22),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ATLETA & ACCOUNT', style: AppTypography.tagUppercase.copyWith(fontSize: 11)),
            Text('PROFILO', style: AppTypography.headlineEditorialSm.copyWith(fontSize: 18)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('CESARE NEGRO', style: AppTypography.headlineEditorialSm.copyWith(fontSize: 20)),
                            const SizedBox(width: 8),
                            const Icon(Icons.verified, size: 18, color: AppColors.volt),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text('SOCIO BLACK ELITE', style: AppTypography.tagUppercase.copyWith(color: AppColors.volt, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text('ID: #KN-88291 · KINETIC CLUB MILANO', style: AppTypography.bodyDefault.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
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
              Icons.palette_outlined,
              'Tema dell App',
              currentThemeMode == AppThemeMode.cool ? 'Tema Attivo: COOL (#CBCBCB)' : 'Tema Attivo: KINETIC OBSIDIAN (Default)',
              onTap: () => _showThemeSelector(context, ref, currentThemeMode),
            ),
            _buildMenuItem(Icons.credit_card_outlined, 'Metodi di Pagamento & Fatture', 'Mastercard •••• 4242'),
            _buildMenuItem(Icons.calendar_today_outlined, 'Storico Prenotazioni & Presenze', '24 sessioni chiuse'),
            _buildMenuItem(Icons.fitness_center_outlined, 'Storico Massimali & Progressioni', 'Ultimo log: Oggi'),
            _buildMenuItem(Icons.privacy_tip_outlined, 'Privacy & Consensi GDPR', 'Verificato EU'),
            _buildMenuItem(Icons.support_agent_outlined, 'Assistenza Reception & Regolamento', 'Aperto fino alle 22:30'),
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

  Widget _buildMenuItem(IconData icon, String title, String subtitle, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.carbonSurface1,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.hairline),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: AppColors.volt),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.bodyDefault.copyWith(fontWeight: FontWeight.w600, fontSize: 16)),
                  const SizedBox(height: 3),
                  Text(subtitle, style: AppTypography.bodyCompact.copyWith(fontSize: 14)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
