import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/telemetry_tile.dart';
import '../../../core/components/section_header.dart';
import '../../../core/components/action_pill.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.obsidianCore,
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
                color: AppColors.carbonSurface1,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.hairline),
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
            SectionHeader(title: 'Opzioni & Sicurezza'),
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

  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
    return Container(
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
    );
  }
}
