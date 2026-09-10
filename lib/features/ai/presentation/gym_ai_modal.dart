import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/components/action_pill.dart';
import '../../../core/state/gym_state_providers.dart';

enum AiScenario { concierge, courseRecommendation, trainingAdaptation, nutritionAssistant }

class GymAiModal extends ConsumerStatefulWidget {
  const GymAiModal({super.key});

  @override
  ConsumerState<GymAiModal> createState() => _GymAiModalState();
}

class _GymAiModalState extends ConsumerState<GymAiModal> {
  AiScenario _activeScenario = AiScenario.concierge;
  final TextEditingController _promptController = TextEditingController();
  bool _isLoading = false;
  String? _aiResponse;
  String? _proposedActionLabel;
  VoidCallback? _onConfirmAction;

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  void _triggerAiRequest(String userPrompt, AiScenario scenario) {
    setState(() {
      _isLoading = true;
      _aiResponse = null;
      _proposedActionLabel = null;
      _onConfirmAction = null;
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        switch (scenario) {
          case AiScenario.courseRecommendation:
            _aiResponse = 'In base alla sessione pesante di spinta di ieri e ai tuoi 45 minuti liberi stasera, ti raccomando:\n\n'
                '• "Mobility & Joint Flow" — Oggi ore 18:30 (Sala Studio 1)\n'
                'Motivazione: Ideale per scaricare il cingolo scapolare e migliorare il recupero attivo.';
            _proposedActionLabel = 'PRENOTA MOBILITY FLOW (ORE 18:30)';
            _onConfirmAction = () {
              ref.read(coursesProvider.notifier).bookSession('sess_1');
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✦ AI: Prenotazione Mobility & Joint Flow confermata!')),
              );
            };
            break;

          case AiScenario.trainingAdaptation:
            _aiResponse = 'Hai solo 30 minuti oggi invece dei 48 previsti.\n\n'
                'Ho adattato la scheda "FORZA PARTE SUPERIORE":\n'
                '1. Mantenuto Panca Piana a 3 serie pesanti.\n'
                '2. Unito Rematore e Military Press in superserie (jump-set).\n'
                '3. Rimossi i Dip accessori per rispettare il tempo limite senza perdere lo stimolo sui fondamentali.';
            _proposedActionLabel = 'APPLICA ADATTAMENTO AL WORKOUT DI OGGI';
            _onConfirmAction = () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✦ AI: Scheda adattata temporaneamente a 30 min.')),
              );
            };
            break;

          case AiScenario.nutritionAssistant:
            _aiResponse = 'Ti mancano ancora 28g di proteine per raggiungere il tuo target di 160g odierno.\n\n'
                'Idee per la cena bilanciata:\n'
                '• 250g Filetto di Orata al cartoccio con erbe aromatiche (+45g PRO)\n'
                '• Oppure 200g Tagliata di pollo con contorno di asparagi (+48g PRO)';
            _proposedActionLabel = 'AGGIUNGI SUGGERIMENTO AL DIARIO NUTRIZIONE';
            _onConfirmAction = () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✦ AI: Pasto registrato nel diario nutrizionale.')),
              );
            };
            break;

          case AiScenario.concierge:
            _aiResponse = 'Ciao Cesare! Il tuo abbonamento Black Unlimited è attivo fino al 31 Dicembre.\n'
                'Oggi hai programmato il workout di Spinta (Fase II Ipertrofia) e ci sono ancora posti disponibili per la sessione Functional Training delle 19:30.';
            _proposedActionLabel = null;
            break;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.carbonSurface1,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        border: Border(top: BorderSide(color: AppColors.hairline)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('✦', style: TextStyle(color: AppColors.volt, fontSize: 16)),
                    const SizedBox(width: 8),
                    Text(
                      'GYM AI · OPENAI GPT-5.6 SOL',
                      style: AppTypography.tagUppercase.copyWith(
                        color: AppColors.volt,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.textSecondary, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Quick Assistant Selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildScenarioChip('Concierge', AiScenario.concierge, 'Cosa posso fare oggi?'),
                  const SizedBox(width: 8),
                  _buildScenarioChip('Raccomandazione Corsi', AiScenario.courseRecommendation, 'Che corso mi consigli per stasera?'),
                  const SizedBox(width: 8),
                  _buildScenarioChip('Adattamento Scheda', AiScenario.trainingAdaptation, 'Ho solo 30 minuti oggi, adatta la scheda'),
                  const SizedBox(width: 8),
                  _buildScenarioChip('Assistente Nutrizione', AiScenario.nutritionAssistant, 'Quante proteine mi mancano oggi?'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Response Box / Loading
            if (_isLoading)
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.carbonSurface2,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.hairline),
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.volt),
                      ),
                      SizedBox(width: 12),
                      Text('Elaborazione contesto palestra con GPT-5.6 Sol...', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                ),
              )
            else if (_aiResponse != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.carbonSurface2,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.volt.withOpacity(0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.auto_awesome, size: 14, color: AppColors.volt),
                        const SizedBox(width: 6),
                        Text('RISPOSTA AI STRUTTURATA', style: AppTypography.tagUppercase.copyWith(color: AppColors.volt, fontSize: 9)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_aiResponse!, style: AppTypography.bodyDefault.copyWith(height: 1.4)),
                    if (_proposedActionLabel != null) ...[
                      const SizedBox(height: 16),
                      ActionPill(
                        label: _proposedActionLabel!,
                        icon: Icons.check,
                        onPressed: _onConfirmAction,
                      ),
                    ],
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.carbonSurface2,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.hairline),
                ),
                child: Text(
                  'Seleziona uno scenario rapido in alto oppure scrivi una richiesta per interrogare il tuo personal concierge di allenamento e nutrizione.',
                  style: AppTypography.bodyCompact,
                ),
              ),
            const SizedBox(height: 16),

            // Input TextField
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promptController,
                    style: AppTypography.bodyDefault,
                    decoration: InputDecoration(
                      hintText: 'Chiedi al Gym AI Concierge...',
                      hintStyle: AppTypography.bodyDefault.copyWith(color: AppColors.textSecondary),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: (val) {
                      if (val.trim().isNotEmpty) {
                        _triggerAiRequest(val, AiScenario.concierge);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                IconButton.filled(
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.volt,
                    foregroundColor: AppColors.onVolt,
                  ),
                  icon: const Icon(Icons.arrow_upward, size: 20),
                  onPressed: () {
                    final val = _promptController.text.trim();
                    if (val.isNotEmpty) {
                      _triggerAiRequest(val, AiScenario.concierge);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioChip(String label, AiScenario scenario, String presetPrompt) {
    final isSelected = _activeScenario == scenario;
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeScenario = scenario;
          _promptController.text = presetPrompt;
        });
        _triggerAiRequest(presetPrompt, scenario);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.volt : AppColors.carbonSurface2,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: isSelected ? AppColors.volt : AppColors.hairline),
        ),
        child: Text(
          label.toUpperCase(),
          style: AppTypography.tagUppercase.copyWith(
            color: isSelected ? AppColors.onVolt : AppColors.textPrimary,
            fontSize: 9,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
