import '../models/daily_item.dart';

class DailiesLibrary {
  static final List<DailyItem> preloadedDailies = _generate90Dailies();

  static List<DailyItem> _generate90Dailies() {
    final List<DailyItem> items = [];
    final now = DateTime.now();

    // 1. WORKOUT OF THE DAY (24 items)
    final wodTemplates = [
      (
        'Ipertrofia Petto & Deltoidi',
        'Petto & Spalle',
        '35 MIN',
        'Focus su spinte su panca inclinata con manubri, chest dip zavorrate e alzate laterali a 45 gradi con contrazione di picco.',
        ['Panca inclinata manubri: 4x8-10', 'Chest Dips: 3x10-12', 'Alzate laterali cavo: 4x15', 'Face pulls: 3x15'],
      ),
      (
        'Forza Massimale Stacco & Schiena',
        'Dorsali & Femorali',
        '45 MIN',
        'Costruzione di forza pura nella catena posteriore. Rispettare i recuperi completi di 3 minuti sui set pesanti.',
        ['Stacco da terra conventionale: 5x3', 'Trazioni alla sbarra con zavorra: 4x6', 'Rematore con bilanciere: 4x8', 'Hyperextension 45°: 3x12'],
      ),
      (
        'Condizionamento Metabolico Full Body',
        'Full Body & VO2',
        '30 MIN',
        'Circuit training ad alta intensità per massimizzare il dispendio energetico e la resistenza cardiocircolatoria.',
        ['Kettlebell Swing: 5x20', 'Assault Bike: 5x45 sec sprint', 'Burpees over bar: 5x15', 'Wall Balls 9kg: 5x20'],
      ),
      (
        'Leg Day Dominanza Quadricipiti',
        'Gambe & Core',
        '50 MIN',
        'Squat pesante seguito da lavoro unilaterale e isolamento finale per un pump intramuscolare totale.',
        ['Back Squat al parallelo: 4x6', 'Bulgarian Split Squat: 3x10 per gamba', 'Leg Press 45° con piedi bassi: 4x12', 'Leg Extension: 3x15 con drop set'],
      ),
      (
        'Upper Body Volume & Pump',
        'Braccia & Spalle',
        '40 MIN',
        'Sessione ad alto volume per stimolare sarcoplasma e micro-ipertrofia nei distretti di supporto.',
        ['Military Press bilanciere: 4x8', 'Curl bicipiti su panca Scott: 4x10', 'French Press con bilanciere sagomato: 4x10', 'Hammer Curl cavo: 3x15'],
      ),
      (
        'Core Pillar & Anti-Rotazione',
        'Addome & Stabilità',
        '25 MIN',
        'Rinforzo della fascia addominale profonda e stabilizzatori lombari mediante contrazioni isometriche e anti-flessione.',
        ['Pallof Press con elastico: 4x12', 'Hanging Leg Raises: 4x12', 'Ab Wheel Rollout: 4x10', 'Plank pesante con disco sulla schiena: 3x60s'],
      ),
    ];

    int idCounter = 1;

    for (int i = 0; i < 24; i++) {
      final t = wodTemplates[i % wodTemplates.length];
      final dayOffset = i;
      items.add(
        DailyItem(
          id: 'wod_${idCounter++}',
          title: i < wodTemplates.length ? t.$1 : '${t.$1} Vol. ${(i ~/ wodTemplates.length) + 1}',
          subtitle: t.$2,
          category: DailyCategory.workoutOfDay,
          durationOrMetric: t.$3,
          imageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=800&auto=format&fit=crop',
          author: 'Coach Andrea',
          description: t.$4,
          bulletPoints: t.$5,
          ctaLabel: 'Inizia Workout',
          ctaAction: 'start_wod',
          publishedAt: now.subtract(Duration(days: dayOffset)),
        ),
      );
    }

    // 2. MEAL OF THE DAY (24 items)
    final mealTemplates = [
      (
        'Salmone Selvaggio e Quinoa con Avocado',
        'Pranzo · 680 kcal',
        '48g PRO',
        'Piatto bilanciato ricco di acidi grassi essenziali Omega-3, carboidrati a basso indice glicemico e micronutrienti antiossidanti.',
        ['200g filetto di salmone scottato', '80g quinoa cotta con curcuma', '60g avocado a fette con lime', 'Zucchine e asparagi alla griglia'],
      ),
      (
        'Bowl Proteica Manzo Scelto e Riso Basmati',
        'Cena · 720 kcal',
        '55g PRO',
        'La classica combinazione per il recupero post-allenamento. Eccellente contenuto di ferro e creatina biodisponibile.',
        ['220g controfiletto di manzo magro', '90g riso basmati aromatico', 'Broccoli al vapore con olio evo a crudo', 'Salsa tahina e semi di sesamo'],
      ),
      (
        'Pancake Proteici Avena & Mirtilli',
        'Colazione · 510 kcal',
        '42g PRO',
        'Colazione ad alta densità nutrizionale senza zuccheri raffinati. Rilascio graduale di glucosio per tutta la mattinata.',
        ['80g farina di avena integrale', '150g albume pastorizzato', '30g proteine isolate del siero del latte', 'Mirtilli freschi e cannella'],
      ),
      (
        'Tagliata di Pollo al Rosmarino e Patate Dolci',
        'Cena · 610 kcal',
        '50g PRO',
        'Fonte proteica magra combinata con carboidrati complessi ricchi di beta-carotene e potassio per contrastare i crampi.',
        ['250g petto di pollo marinato con erbe', '200g patate dolci al forno', 'Insalata di spinacini freschi con noci', 'Olio extravergine 10g'],
      ),
    ];

    for (int i = 0; i < 24; i++) {
      final t = mealTemplates[i % mealTemplates.length];
      final dayOffset = i;
      items.add(
        DailyItem(
          id: 'meal_${idCounter++}',
          title: i < mealTemplates.length ? t.$1 : '${t.$1} (Variante ${(i ~/ mealTemplates.length) + 1})',
          subtitle: t.$2,
          category: DailyCategory.mealOfDay,
          durationOrMetric: t.$3,
          imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?q=80&w=800&auto=format&fit=crop',
          author: 'Dott.ssa Laura (Nutrizionista)',
          description: t.$4,
          bulletPoints: t.$5,
          ctaLabel: 'Aggiungi al Diario',
          ctaAction: 'log_meal',
          publishedAt: now.subtract(Duration(days: dayOffset)),
        ),
      );
    }

    // 3. TRAINER TIP (24 items)
    final tipTemplates = [
      (
        'Ottimizzazione della Curva di Forza nella Panca',
        'Biomeccanica & Tecnica',
        'LETTURA 2 MIN',
        'Per massimizzare il reclutamento del gran pettorale, ritrai e deprimi attivamente le scapole prima di staccare il bilanciere dai supporti.',
        ['Crea un arco fisiologico solido con i piedi ben piantati', 'Traiettoria del bilanciere leggermente curvilinea (a J inversa)', 'Mantieni i gomiti a circa 45-60 gradi dal tronco'],
      ),
      (
        'Il Ruolo del Sonno a Onde Lente nel Recupero',
        'Fisiologia & Performance',
        'LETTURA 3 MIN',
        'L85% dell ormone della crescita (GH) viene secreto durante le fasi di sonno profondo (NREM). 7-8 ore non sono un optional ma parte dell allenamento.',
        ['Stanza a temperatura controllata tra 18°C e 20°C', 'Spegnimento schermi blu almeno 45 minuti prima del riposo', 'Evitare caffeina nelle 8 ore precedenti'],
      ),
      (
        'Gestione del Volume Settimanale per Gruppo Muscolare',
        'Programmazione',
        'LETTURA 2 MIN',
        'Il range ottimale per la maggior parte degli atleti intermedi si attesta tra 12 e 20 serie allenanti per gruppo muscolare a settimana.',
        ['Dividi il volume su almeno 2 frequenze settimanali', 'Non contare le serie di riscaldamento nel volume totale', 'Mantieni un RPE compreso tra 7 e 9'],
      ),
      (
        'Idratazione Intracellulare ed Elettroliti',
        'Idratazione & Forza',
        'LETTURA 1 MIN',
        'Un calo del 2% del peso corporeo in liquidi porta a una perdita fino al 15% della forza esplosiva massimale.',
        ['Bevi almeno 40ml di acqua per kg di peso corporeo', 'Aggiungi un pizzico di sale marino non raffinato pre-workout', 'Monitora il colore delle urine come bio-marker immediato'],
      ),
    ];

    for (int i = 0; i < 24; i++) {
      final t = tipTemplates[i % tipTemplates.length];
      final dayOffset = i;
      items.add(
        DailyItem(
          id: 'tip_${idCounter++}',
          title: i < tipTemplates.length ? t.$1 : '${t.$1} - Parte ${(i ~/ tipTemplates.length) + 1}',
          subtitle: t.$2,
          category: DailyCategory.trainerTip,
          durationOrMetric: t.$3,
          imageUrl: 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?q=80&w=800&auto=format&fit=crop',
          author: 'Head Coach Marco',
          description: t.$4,
          bulletPoints: t.$5,
          ctaLabel: 'Approfondisci',
          ctaAction: 'read_tip',
          publishedAt: now.subtract(Duration(days: dayOffset)),
        ),
      );
    }

    // 4. CHALLENGE OF THE DAY (24 items)
    final challengeTemplates = [
      (
        '100 Dips Zavorrate o a Corpo Libero',
        'Resistenza Muscolare',
        'CHALLENGE',
        'Completa 100 parallele nel minor tempo possibile mantenendo il range di movimento completo a 90 gradi.',
        ['Tempo limite: 12 minuti', 'Registra il numero totale di serie necessarie', 'Forma pulita senza oscillazioni con le gambe'],
      ),
      (
        '3 Minuti di Plank Ininterrotto',
        'Stabilità Isometrica',
        'CHALLENGE',
        'Metti alla prova la tenuta del tuo core. Nessuna pausa, glutei e addominali contratti al 100%.',
        ['Cronometro attivo dal primo secondo', 'Posizione orizzontale perfetta', 'Condividi il tuo risultato nel feed della community'],
      ),
      (
        '2.000 Metri al Vogatore Concept2 Sub 7:30',
        'Cardio Performance',
        'CHALLENGE',
        'Il test di riferimento per la capacità polmonare e la potenza lattacida sulle gambe e sul dorso.',
        ['Damper impostato tra 4 e 6', 'Pacing costante sui 500m split', 'Riscaldamento preventivo obbligatorio di 5 minuti'],
      ),
      (
        '50 Ripetizioni di Stacco al 100% del Peso Corporeo',
        'Resistenza alla Forza',
        'CHALLENGE',
        'Carica sul bilanciere esattamente il tuo peso corporeo e chiudi 50 ripetizioni controllate nel minor tempo.',
        ['Ogni ripetizione deve toccare terra senza rimbalzo', 'Usa cintura di sollevamento se necessario', 'Idratazione costante'],
      ),
    ];

    for (int i = 0; i < 24; i++) {
      final t = challengeTemplates[i % challengeTemplates.length];
      final dayOffset = i;
      items.add(
        DailyItem(
          id: 'ch_${idCounter++}',
          title: i < challengeTemplates.length ? t.$1 : '${t.$1} - Livello ${(i ~/ challengeTemplates.length) + 1}',
          subtitle: t.$2,
          category: DailyCategory.challengeOfDay,
          durationOrMetric: t.$3,
          imageUrl: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=800&auto=format&fit=crop',
          author: 'Club Challenge Board',
          description: t.$4,
          bulletPoints: t.$5,
          ctaLabel: 'Accetta la Sfida',
          ctaAction: 'accept_challenge',
          publishedAt: now.subtract(Duration(days: dayOffset)),
        ),
      );
    }

    return items;
  }
}
