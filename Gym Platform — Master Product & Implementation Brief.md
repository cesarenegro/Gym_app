# GYM PLATFORM
## Master Product & Implementation Brief

**Status:** Functional + Technical Brief  
**Release model:** Single complete release  
**Project name:** TBD  
**Target market:** Italy / EU  
**Primary platforms:** iOS + Android  
**Member application:** Flutter  
**Club/Admin interface:** Flutter responsive application / Flutter Web  
**Backend:** Supabase  
**Database:** Supabase PostgreSQL  
**Authentication / OAuth:** Supabase Auth  
**AI:** OpenAI GPT-5.6 Sol API  
**Repository:** GitHub  
**Coder:** Antigravity  
**Auditor:** Claude Fable 5  

---

# 1. PROJECT OBJECTIVE

The product must not be conceived as a traditional gym-management application adapted to mobile.

The objective is to create one integrated digital ecosystem connecting:

**GYM → MEMBERS → TRAINERS → COURSES → TRAINING → NUTRITION → COMMUNITY → MARKETPLACE → AI**

The member application must become the member's primary daily interface with the gym.

The platform must combine:

- gym management;
- course booking;
- membership management;
- payments;
- training calendar;
- workout management;
- nutrition;
- gym/member community;
- sports marketplace;
- Dailies editorial content;
- AI-assisted functions.

The final experience should feel closer to a modern consumer application than to an ERP or administrative portal.

---

# 2. CORE PRODUCT PRINCIPLE

The fundamental user loop is:

**DISCOVER → BOOK → TRAIN → TRACK → EAT → SHARE → SHOP → RETURN**

These modules must not behave like separate applications.

Information generated in one module must be usable by the others.

Example:

A member books a Functional Training class.

That booking:

1. appears automatically in MY CALENDAR;
2. appears on HOME as the next scheduled activity;
3. can influence AI Course Recommendation;
4. can be considered by AI Training Adaptation;
5. produces the appropriate reminder;
6. enters the member's activity history.

The platform must therefore have **one coherent member profile and one coherent activity timeline**.

---

# 3. USER TYPES

Minimum roles:

### 3.1 MEMBER

Normal gym member.

Can:

- manage profile;
- manage membership;
- make payments;
- book courses;
- join waitlists;
- view personal calendar;
- perform workouts;
- log workout results;
- access nutrition;
- interact with AI;
- consume Dailies;
- publish community content;
- publish marketplace products if enabled;
- buy marketplace products;
- comment/react where allowed.

---

### 3.2 TRAINER

Can additionally:

- manage assigned members;
- create or assign workout programmes;
- review workout progress;
- manage classes assigned to them;
- publish Trainer Tips;
- publish authorised community content;
- contribute to Dailies;
- answer member interactions where supported.

A trainer does **not automatically receive unrestricted access to all member data**.

Permissions must be scoped to the trainer-member relationship.

---

### 3.3 GYM ADMIN

Can manage:

- gym profile;
- members;
- trainers;
- courses;
- schedules;
- memberships;
- packages;
- bookings;
- waiting lists;
- products;
- Dailies;
- community posts;
- moderation;
- payments status;
- notifications;
- basic operational reports;
- AI-related content/context available for the gym.

---

### 3.4 PLATFORM ADMIN

Global administrative role.

Can manage:

- gyms;
- platform configuration;
- user reports;
- moderation escalations;
- system content;
- platform Dailies;
- categories;
- AI configuration;
- system health;
- platform-wide permissions.

---

# 4. MEMBER APP INFORMATION ARCHITECTURE

The mobile application should expose only five principal navigation areas.

## HOME

Personal daily dashboard.

## TRAIN

Workout programme, calendar and progress.

## BOOK

Courses, classes and reservations.

## COMMUNITY

Dailies, social feed and marketplace.

## PROFILE

Membership, payments, personal information and settings.

The user must never need to understand the underlying management system.

---

# 5. WHAT “MODERN MEMBER APP” MEANS

“Modern Member App” is a product requirement, not simply a visual definition.

It means:

### Consumer-first UX

The interface is designed for members rather than administrators.

### Personalised HOME

The first screen immediately answers:

- What am I doing today?
- What is my next class?
- How is my week going?
- What should I do next?

### Immediate actions

Critical operations should normally require very few steps.

Examples:

**BOOK**

**START WORKOUT**

**PAY**

**SHOP**

### Visual-first interface

Use:

- cards;
- imagery;
- video;
- progress indicators;
- horizontal content rails;
- Dailies;
- clear typography;
- strong hierarchy.

Avoid spreadsheet-like UI.

### Contextual content

The member should see information relevant to that moment rather than generic menus.

### Continuous state

Bookings, workouts, nutrition and memberships must update the rest of the app consistently.

### Fast perceived performance

Use:

- loading states;
- skeleton states where appropriate;
- optimistic UI only where transaction safety permits;
- cached non-sensitive content where useful;
- graceful offline/error states.

### Native mobile behaviour

The app must feel appropriate on iOS and Android while retaining a common Flutter codebase.

Flutter officially supports shared cross-platform application development while allowing access to platform-specific services. citeturn542796search6

---

# 6. HOME

HOME is the most important screen in the member app.

It must act as the user's **daily command centre**.

Suggested content order:

## 6.1 HEADER

Profile picture.

Greeting.

Optional gym identity.

Example:

**GOOD MORNING, CESARE**

---

# 6.2 DAILIES

Immediately visible near the top.

Horizontal circular or compact visual cards.

Categories:

- Workout of the Day
- Meal of the Day
- Trainer Tip
- Challenge of the Day

Tap opens immersive vertical content.

---

# 6.3 TODAY

Primary card.

Example:

**TODAY**

Upper Body  
45 min  
18:30

**START WORKOUT**

If no workout is scheduled:

**NO WORKOUT PLANNED**

with suitable alternative action.

---

# 6.4 NEXT CLASS

Example:

**NEXT CLASS**

Functional Training  
19:30  
Trainer: Andrea  
6 spots left

**VIEW**

or

**BOOK**

depending on status.

---

# 6.5 YOUR WEEK

Simple progress representation.

Example:

**3 / 4 workouts completed**

No advanced predictive analytics are required.

---

# 6.6 NUTRITION SNAPSHOT

Compact summary.

Example:

**TODAY**

Protein 118 / 150 g

1,650 / 2,100 kcal

**VIEW NUTRITION**

This card should only appear if the user is using the Nutrition module.

---

# 6.7 COMMUNITY / FOR YOU

Selected recent:

- Dailies;
- gym posts;
- trainer content;
- member content;
- marketplace products;
- challenges.

---

# 6.8 QUICK ACTIONS

Maximum four prominent shortcuts:

**BOOK**

**TRAIN**

**PAY**

**SHOP**

---

# 7. DAILIES

Dailies are a core engagement feature.

They are not temporary social Stories copied literally from Instagram.

They are structured editorial micro-content intended to make the application useful every day.

---

# 7.1 INITIAL CONTENT LIBRARY

The platform must launch with **at least 90 preloaded Dailies** distributed across:

### WORKOUT OF THE DAY

Short workout ideas.

### MEAL OF THE DAY

Food/meal inspiration.

### TRAINER TIP

Concise fitness, technique, consistency or lifestyle advice.

### CHALLENGE OF THE DAY

Simple user challenges.

The final distribution between the four categories will be editorially determined.

Requirement:

**TOTAL PRELOADED CONTENT ≥ 90**

---

# 7.2 DAILY CONTENT MODEL

Each Daily must support, according to type:

- title;
- category;
- visual;
- optional video;
- short text;
- optional expanded content;
- CTA;
- publication status;
- publication date;
- gym/platform source;
- duration/display rules where needed.

Exact database fields are to be defined by Antigravity and audited before migration creation.

---

# 7.3 CONTENT SOURCES

A Daily can originate from:

**PLATFORM**

Preloaded centrally.

**GYM**

Created by the individual gym.

**TRAINER**

Created by authorised trainers.

---

# 7.4 DAILIES MANAGEMENT

Gym/Admin must be able to:

- create;
- edit;
- preview;
- publish;
- schedule;
- unpublish;
- archive.

Preloaded platform Dailies can be selected and reused by participating gyms according to platform rules.

---

# 8. COURSES

The platform must contain a complete catalogue of activities offered by the gym.

Examples:

- Functional Training;
- Yoga;
- Pilates;
- Spinning;
- Cross Training;
- Mobility;
- Boxing;
- Strength;
- Swimming;
- Padel;
- other gym-defined activities.

The system must not hard-code the categories above.

---

# 8.1 COURSE DETAIL

Each course should expose relevant information such as:

- name;
- image;
- description;
- trainer;
- difficulty/level if used;
- duration;
- schedule;
- location/room;
- capacity;
- available places;
- booking state;
- relevant membership eligibility.

Exact fields remain part of the implementation data-model design.

---

# 8.2 COURSE SCREEN

A user must be able to:

- browse courses;
- search/filter available courses;
- open course detail;
- see upcoming sessions;
- identify trainer;
- check availability;
- book;
- cancel according to rules;
- join a waiting list when applicable;
- add the booked activity automatically to MY CALENDAR.

---

# 9. BOOKING

Booking must support more than generic class reservation.

Potential bookable resources must be designed as extensible entities.

Initial scope:

- courses/classes;
- trainer/PT appointments where enabled;
- gym-defined bookable activities.

---

# 9.1 BOOKING FLOW

Recommended flow:

**SELECT ACTIVITY**

↓

**SELECT DATE/TIME**

↓

**VERIFY AVAILABILITY**

↓

**VERIFY MEMBERSHIP / REQUIRED CREDIT**

↓

**CONFIRM**

↓

**BOOKING CREATED**

↓

**CALENDAR UPDATED**

↓

**NOTIFICATION / CONFIRMATION**

---

# 9.2 WAITLIST

Where a session is full:

**JOIN WAITLIST**

The system records order/priority according to gym rules.

When a space becomes available, the configured club policy determines whether:

- the next user receives an invitation;
- or the system performs an automatic promotion.

The policy must be configurable rather than hard-coded.

---

# 9.3 BOOKING PROTECTION

Booking capacity must be validated server-side.

The Flutter UI must never be considered the authoritative source for seat availability.

Concurrent booking must not allow the capacity to be exceeded.

---

# 10. MY CALENDAR

MY CALENDAR must combine all relevant gym activity.

It is not only the course calendar.

Possible items:

- personal workouts;
- booked classes;
- PT appointments;
- challenges;
- gym events.

Example:

**MONDAY**

18:00 — Upper Body

19:00 — Functional Training

**WEDNESDAY**

18:30 — PT / Andrea

**FRIDAY**

Rest Day

---

# 10.1 CALENDAR VIEWS

At minimum:

- upcoming;
- day;
- week;
- calendar overview.

The exact visual implementation is a UX decision.

---

# 11. TRAINING

Training must not be implemented as static PDFs.

Workout programmes need structured exercise data.

---

# 11.1 TRAINING HOME

Show:

- today's workout;
- upcoming workout;
- current programme;
- recent completed workouts;
- simple progress.

---

# 11.2 WORKOUT

Workout contains ordered exercises.

Example:

**BENCH PRESS**

4 × 8

Target: 70 kg

Previous:
67.5 kg

**START SET**

The application should allow logging of relevant training data such as:

- completed sets;
- repetitions;
- load;
- completion status;
- optional perceived difficulty;
- optional notes.

The final supported metrics must be defined according to exercise type.

---

# 11.3 EXERCISE LIBRARY

Exercise items may include:

- exercise name;
- category;
- instructions;
- image/video;
- primary muscle groups;
- workout parameters.

Gym admins/trainers must be able to use the exercise library when constructing programmes.

---

# 11.4 WORKOUT HISTORY

Members can review:

- completed workouts;
- exercises;
- loads/repetitions;
- basic progression.

This release does **not** include advanced predictive performance analytics.

---

# 12. NUTRITION

Nutrition must be positioned as fitness/wellness support.

It must not present AI-generated output as medical diagnosis or clinical treatment.

---

# 12.1 NUTRITION HOME

Example:

**TODAY**

1,870 / 2,250 kcal

Protein  
132 / 160 g

Carbohydrates  
180 / 240 g

Fat  
54 / 70 g

Breakfast ✓  
Lunch ✓  
Snack  
Dinner

---

# 12.2 FUNCTIONS

Member can access:

- daily nutrition target;
- meals;
- meal plan when assigned;
- food/meal entries;
- calorie summary;
- macro summary;
- nutrition history;
- Meal of the Day Dailies;
- AI Nutrition Assistant.

---

# 12.3 HUMAN-AUTHORED PLANS VS AI

The application must clearly distinguish:

**ASSIGNED PLAN**

Created/approved by an authorised professional or gym role.

from

**AI SUGGESTION**

Generated dynamically by the AI assistant.

They must never be visually confused.

---

# 13. COMMUNITY

COMMUNITY combines three systems:

### DAILIES

Curated daily content.

### SOCIAL FEED

Gym/member/trainer content.

### MARKETPLACE

Products embedded within the social environment.

The interface should feel coherent rather than presenting three separate applications.

---

# 14. SOCIAL FEED

The feed is inspired by familiar social patterns, but must remain gym-focused.

Supported content types:

- standard post;
- image;
- short video;
- gym announcement;
- trainer content;
- achievement;
- challenge;
- marketplace listing;
- Daily.

---

# 14.1 MEMBER ACTIONS

According to club settings:

- publish;
- view;
- react;
- comment;
- save;
- report.

The exact social interaction set should remain controlled rather than attempting to reproduce all Instagram functionality.

---

# 14.2 GYM CONTENT

Gym can post:

- news;
- promotions;
- new courses;
- events;
- products;
- trainer announcements;
- challenges;
- Dailies.

---

# 14.3 MODERATION

This is mandatory, not optional.

Because the application contains user-generated content, both Apple and Google require meaningful moderation mechanisms. Apple explicitly requires filtering objectionable material, reporting, blocking abusive users and published contact information; Google similarly requires terms, reporting/blocking and ongoing moderation. citeturn425792search0turn425792search1

Required functions therefore include:

- report post;
- report comment;
- report listing;
- report user;
- block user;
- hide/remove content;
- moderator review;
- moderation status;
- Terms of Use acceptance;
- community guidelines;
- moderation audit trail.

Content creation cannot be implemented without this moderation layer.

---

# 15. SPORTS MARKETPLACE

Marketplace is a strategic feature.

It must not appear as an isolated traditional e-commerce section.

Products can enter the same visual ecosystem as community posts.

---

# 15.1 SELLERS

Two initial seller types:

### GYM

Official gym products.

### MEMBER

Member-to-member listings.

---

# 15.2 EXAMPLE

**MARCO ROSSI**

Nike Metcon 9  
Size 43  
€70

[IMAGE]

**VIEW PRODUCT**

**BUY / CONTACT SELLER**

---

**GYM CLUB**

New training T-shirt

[VIDEO]

€29

**BUY**

---

# 15.3 PRODUCT CATEGORIES

Initial taxonomy should be configurable.

Examples could include:

- sports apparel;
- footwear;
- accessories;
- gym equipment;
- training accessories;
- official gym merchandise.

Categories must not be permanently hard-coded.

---

# 15.4 LISTING CREATION

Member can create a marketplace listing with:

- product information;
- photos;
- description;
- category;
- price;
- condition where applicable.

Exact required fields must be established during schema design.

Listings can be:

- pending review;
- published;
- reserved;
- sold;
- rejected;
- archived.

---

# 15.5 MARKETPLACE + FEED

Every published product may generate a social-format marketplace card.

Users should therefore be able to discover a product:

**FROM SHOP**

or

**FROM COMMUNITY FEED**

without duplicating the underlying listing.

---

# 15.6 TRANSACTIONS

Marketplace must be architected for payments.

However:

**PAYMENT SERVICE PROVIDER HAS NOT YET BEEN SELECTED.**

Antigravity must therefore implement a payment abstraction rather than binding business logic directly to an unapproved vendor.

Required conceptual flow:

**PRODUCT**

→ **PURCHASE INTENT**

→ **SERVER VALIDATION**

→ **PAYMENT PROVIDER**

→ **CONFIRMED PAYMENT**

→ **ORDER**

→ **FULFILMENT / SELLER FLOW**

No order must be marked paid solely because the Flutter client reports success.

---

# 15.7 MEMBER-TO-MEMBER PAYMENTS

A member-to-member marketplace introduces additional payment/payout and identity requirements.

The actual payout model must therefore remain **TBD until the selected payment provider and commercial/legal model have been approved**.

Antigravity must not invent:

- payout logic;
- KYC requirements;
- platform commission structure;
- escrow behaviour;
- seller settlement rules.

These require a separate commercial/payment decision.

---

# 16. MEMBERSHIPS

Member must be able to see:

- current membership;
- status;
- start/end information;
- included services;
- available credits where applicable;
- renew options;
- previous purchases where appropriate.

---

# 16.1 MEMBERSHIP PRODUCTS

Gym Admin must be able to define:

- memberships;
- class packages;
- credits;
- eligible courses/services;
- duration;
- price;
- purchase availability.

Exact billing rules must be configuration driven.

---

# 17. PAYMENTS

Payments apply to:

- memberships;
- renewals;
- packages;
- courses where individually paid;
- gym marketplace products;
- member marketplace transactions when the final marketplace payment model supports them.

---

# 17.1 PAYMENT EXPERIENCE

Member should be able to:

1. select product/service;
2. review amount;
3. choose available payment method;
4. authorise payment;
5. receive clear outcome;
6. access order/payment record.

---

# 17.2 PAYMENT PROVIDER

**TBD**

Do not assume Stripe, Adyen, PayPal or another processor until explicitly selected.

Technical architecture must isolate payment-provider code behind an application service/interface.

---

# 18. AI SYSTEM

AI is not to be distributed everywhere in the application.

This release has exactly four principal AI capabilities:

1. **AI COURSE RECOMMENDATION**
2. **AI TRAINING ADAPTATION**
3. **AI NUTRITION ASSISTANT**
4. **AI GYM CONCIERGE**

AI provider:

**OpenAI GPT-5.6 Sol**

Verified model ID:

`gpt-5.6-sol`

GPT-5.6 Sol currently supports the Responses API, function calling and structured outputs, which are appropriate for controlled application workflows. citeturn542796search0

---

# 19. AI ARCHITECTURE

The Flutter application must **never contain the OpenAI secret API key**.

Required architecture:

**FLUTTER**

↓

**SUPABASE AUTH**

↓

**SUPABASE EDGE FUNCTION / SERVER-SIDE AI GATEWAY**

↓

**PERMISSION + CONTEXT VALIDATION**

↓

**OPENAI GPT-5.6 SOL**

↓

**STRUCTURED RESULT**

↓

**SERVER VALIDATION**

↓

**FLUTTER**

OpenAI calls must occur server-side.

---

# 19.1 AI CONTROL PRINCIPLE

AI can:

- interpret;
- recommend;
- summarise;
- personalise;
- propose an action.

AI must not directly perform sensitive transactional writes without application-level validation.

For important operations:

**AI PROPOSES → USER CONFIRMS → SERVER EXECUTES**

---

# 20. AI COURSE RECOMMENDATION

Purpose:

Help users decide which available course best fits their current context.

Examples:

> What course should I do tonight?

> I trained legs yesterday. What can I book today?

> I have 45 minutes tomorrow.

Potential authorised context:

- available gym sessions;
- user's existing bookings;
- training history;
- stated preferences;
- course level;
- availability;
- schedule.

Expected result must be structured.

Example conceptual response:

**RECOMMENDED**

Mobility Flow  
18:30  
45 min

**WHY**

Appropriate after yesterday's lower-body workout and compatible with your available time.

**BOOK**

AI must recommend only real courses/sessions returned by the platform.

It must never invent:

- courses;
- instructors;
- times;
- availability.

---

# 21. AI TRAINING ADAPTATION

Purpose:

Adapt the member's existing workout plan to realistic circumstances.

Examples:

> I only have 35 minutes.

> I missed Monday and Wednesday.

> Can I move today's workout to tomorrow?

AI receives only authorised training context.

It may propose:

- shortening a workout;
- changing order;
- rescheduling;
- redistributing missed sessions;
- reducing redundant exercises.

The original assigned programme must remain recoverable.

AI adaptations must be identifiable as AI modifications.

---

# 22. AI NUTRITION ASSISTANT

Purpose:

Help the user work within the configured nutrition plan/goals.

Examples:

> How much protein am I missing today?

> Suggest a dinner compatible with what I have eaten.

> I have 500 kcal left. Give me some meal ideas.

Potential authorised context:

- configured target;
- meal history;
- consumed macros;
- assigned nutrition plan;
- stated preferences where stored.

The AI must not claim to diagnose disease or prescribe clinical treatment.

Where health-related issues exceed the intended fitness/wellness scope, the product must present an appropriate limitation rather than fabricate medical guidance.

---

# 23. AI GYM CONCIERGE

This should become the natural-language control layer of the application.

Examples:

> Find me a class tomorrow after 18:00.

> What do I have booked this week?

> When does my membership expire?

> Find a yoga course Saturday morning.

> Show me what I should train today.

> Find me something under €50 in the marketplace.

The Concierge can orchestrate approved application functions.

---

# 23.1 TOOL/ACTION MODEL

The Concierge should not receive unrestricted database access.

Instead it can access controlled application functions conceptually such as:

- search_courses;
- list_available_sessions;
- get_my_bookings;
- get_my_membership;
- get_today_workout;
- get_nutrition_summary;
- search_marketplace;
- prepare_booking;
- prepare_cancellation.

Names above are illustrative contracts, **not mandated final API names**.

---

# 23.2 WRITE ACTIONS

For actions that change state:

Example:

> Book Pilates tomorrow at 18:30.

AI:

**Pilates — 18:30  
Trainer: Sara  
1 membership credit**

**CONFIRM BOOKING**

Only after explicit user confirmation:

→ server validates availability;

→ booking service executes;

→ result returns to member.

AI must never bypass booking, payment or membership rules.

---

# 24. AI OUTPUT CONTROL

Use structured responses wherever the app expects machine-readable actions.

Do not depend on parsing arbitrary prose for transactional functions.

AI responses should distinguish:

- explanatory text;
- referenced entity;
- recommended action;
- CTA/action intent;
- confidence/insufficient data state where applicable.

If context is insufficient:

AI must return an explicit insufficient-data state rather than inventing information.

---

# 25. NOTIFICATIONS

Notifications should cover:

- booking confirmation;
- booking cancellation;
- waitlist updates;
- upcoming class;
- membership expiry;
- successful payment;
- failed payment;
- trainer updates;
- scheduled workout;
- important gym announcements;
- marketplace transaction updates;
- selected Dailies/challenges.

Users need preference controls for non-essential notification classes.

Push implementation provider/service must be formally chosen during implementation; do not assume an unspecified provider.

---

# 26. SEARCH

A unified search/discovery capability should make it possible to find:

- courses;
- trainers;
- marketplace products;
- selected community content.

Search should be contextual to the section rather than exposing internal database concepts.

---

# 27. CLUB / ADMIN CONSOLE

The member app alone is insufficient.

The gym requires an operational interface.

The same Flutter ecosystem may be used, with a responsive admin target, but member and administration UX must remain distinct.

---

# 27.1 ADMIN HOME

Basic operational overview:

- members;
- today's courses;
- upcoming sessions;
- bookings;
- memberships requiring attention;
- marketplace moderation queue;
- community moderation queue.

Avoid unnecessary enterprise analytics in this release.

---

# 27.2 MEMBER MANAGEMENT

Admin can:

- find member;
- view membership;
- view status;
- manage club relationship;
- view relevant bookings;
- manage permitted account/member settings.

---

# 27.3 COURSE MANAGEMENT

Admin can:

- create/edit course;
- create sessions;
- assign trainer;
- set capacity;
- configure booking rules;
- cancel session;
- inspect bookings;
- manage waitlist.

---

# 27.4 MEMBERSHIP MANAGEMENT

Admin can:

- create packages;
- define duration;
- define eligibility;
- define price;
- activate/deactivate products;
- inspect member status.

---

# 27.5 CONTENT MANAGEMENT

Admin can manage:

- Dailies;
- community posts;
- announcements;
- marketplace listings requiring review;
- reported content.

---

# 27.6 MARKETPLACE MANAGEMENT

Admin can:

- publish official gym products;
- edit products;
- manage availability;
- review member listings;
- remove prohibited listings;
- view relevant transaction state.

---

# 28. CONTENT MODERATION SYSTEM

Required statuses should support a moderation lifecycle.

Conceptually:

**PENDING**

**PUBLISHED**

**REPORTED**

**HIDDEN**

**REJECTED**

**ARCHIVED**

Exact database enum implementation is for Antigravity to define and Claude to audit.

There must be traceability of moderator actions.

---

# 29. AUTHENTICATION

Authentication provider:

**SUPABASE AUTH**

Supabase has an official Flutter integration and provides authentication/user-management support through `supabase_flutter`. citeturn542796search1

OAuth architecture:

**SUPABASE AUTH**

Specific social OAuth providers are **not defined in this brief**.

Antigravity must not assume Google, Apple, Facebook or others until selected.

Mobile OAuth should follow the supported secure flow; Supabase documents OAuth 2.1 Authorization Code with PKCE as the recommended flow for mobile clients. citeturn542796search9

---

# 30. BACKEND

Backend platform:

**SUPABASE**

Verified available components relevant to this product include:

- PostgreSQL;
- Auth;
- Storage;
- Realtime;
- Edge Functions;
- Flutter client integration. citeturn542796search1turn542796search2

---

# 31. PROPOSED LOGICAL DATA DOMAINS

The following are **logical domains, not an approved SQL schema**.

Antigravity must design the actual schema and migrations and submit them to Claude Fable 5 audit before finalisation.

Domains required:

### IDENTITY

- profiles
- roles
- gym memberships/relationships

### GYMS

- gyms
- locations
- rooms
- trainers/staff

### COMMERCIAL

- membership products
- active subscriptions/memberships
- packages/credits
- payments
- orders

### COURSES

- courses
- sessions
- bookings
- waitlists

### TRAINING

- exercises
- programmes
- programme workouts
- workout exercises
- workout logs

### NUTRITION

- nutrition plans
- meals
- nutrition logs
- nutrition targets

### CONTENT

- posts
- media
- comments
- reactions
- Dailies
- reports
- moderation actions

### MARKETPLACE

- listings/products
- seller relationship
- marketplace media
- orders
- order items
- transaction state

### AI

- AI requests/session metadata where required
- tool/action audit state
- user-confirmed AI actions

Actual names may differ.

---

# 32. SUPABASE SECURITY

Row Level Security must be treated as mandatory.

The Flutter application uses the client-facing Supabase key only with appropriate database privileges and RLS policies.

Supabase's own Flutter installation documentation explicitly recommends enabling RLS and defining policies before granting client roles access to tables/functions. citeturn542796search5

Minimum principle:

**DENY BY DEFAULT WHERE DATA IS PRIVATE**

Members must never gain access to another member's private:

- payment information;
- private training information;
- private nutrition information;
- account information.

Public/community data must use separate access policies from private data.

---

# 33. STORAGE

Storage classes should be separated conceptually.

Examples:

### PUBLIC / COMMUNITY MEDIA

- public gym imagery;
- approved community posts;
- approved product images.

### PRIVATE USER MEDIA

- private profile or programme content where required;
- private user documents if later enabled.

Do not expose a private storage object simply because a user knows its path.

Access policies must correspond to the content's privacy classification.

---

# 34. REALTIME

Supabase Realtime may be used where realtime behaviour materially improves the experience.

Potential cases:

- remaining course availability;
- waitlist changes;
- selected booking changes;
- community interactions;
- marketplace status.

Do not make all database tables realtime by default.

Use it only where the functional requirement benefits from it.

---

# 35. FLUTTER ARCHITECTURE

Flutter's current architecture guidance emphasises separation of concerns, UI/data layering, single source of truth and testability. citeturn542796search4turn542796search8

The codebase must therefore maintain explicit separation between:

**UI**

↓

**APPLICATION / BUSINESS LOGIC**

↓

**REPOSITORIES / DATA ACCESS**

↓

**SUPABASE / EXTERNAL SERVICES**

Widgets must not contain direct scattered business logic or direct payment/AI implementation logic.

---

# 36. FLUTTER STATE MANAGEMENT

No specific state-management package has been selected by the product owner.

Therefore Antigravity must:

1. evaluate the project requirements;
2. propose the state-management solution;
3. document the choice in an ADR;
4. submit it to Claude Fable 5;
5. only then standardise it across the application.

Do not arbitrarily mix multiple state-management systems.

---

# 37. NAVIGATION

Same principle.

The routing package/implementation is not specified.

Antigravity proposes it once and documents the decision.

Requirements:

- deep-link compatible;
- authentication-aware;
- role-aware;
- suitable for iOS/Android;
- supports AI/action links where required.

---

# 38. PROPOSED GITHUB REPOSITORY ORGANISATION

This is a **project architecture proposal**, not an existing verified repository structure.

Conceptually separate:

- Flutter member application;
- Flutter admin/club application;
- shared domain/design packages;
- Supabase migrations;
- Supabase Edge Functions;
- automated tests;
- documentation;
- architecture decisions.

Antigravity should produce the actual folder structure in the initial architecture PR.

---

# 39. GITHUB WORKFLOW

Recommended engineering loop:

**BRIEF**

↓

**ANTIGRAVITY IMPLEMENTATION**

↓

**CLAUDE FABLE 5 AUDIT**

↓

**ANTIGRAVITY FIX**

↓

**AUTOMATED TESTS / GITHUB ACTIONS**

↓

**CLAUDE FINAL REVIEW**

↓

**MERGE**

Critical branch merges must depend on passing automated checks.

GitHub branch protection can require successful status checks and reviews before merge. citeturn542796search14

---

# 40. ANTIGRAVITY — CODER RESPONSIBILITIES

Antigravity is responsible for:

- architecture proposal;
- Flutter implementation;
- Supabase schema;
- migrations;
- RLS;
- Supabase functions;
- AI gateway;
- test suite;
- payment abstraction;
- state management implementation;
- error handling;
- app performance;
- documentation;
- CI compatibility;
- fixing audit findings.

Antigravity must not silently introduce unspecified external vendors.

Any new service dependency must be documented and justified before adoption.

---

# 41. CLAUDE FABLE 5 — AUDITOR RESPONSIBILITIES

Claude must audit:

### PRODUCT COMPLIANCE

Does implementation match this brief?

### ARCHITECTURE

Is separation of concerns respected?

### DATABASE

Are schema and migrations coherent?

### SECURITY

Are RLS and permissions correct?

### PRIVACY

Are private member data properly separated?

### AI

Can AI bypass server-side permissions?

### TRANSACTIONS

Can payments/bookings be forged client-side?

### MARKETPLACE

Can users publish prohibited/unmoderated content?

### TESTING

Are critical paths covered?

### REGRESSION

Did the change break previously accepted flows?

Audit result for each item:

**PASS**

**FAIL**

**BLOCKER**

**NOT VERIFIED**

Never treat an untested requirement as PASS.

---

# 42. REQUIRED TEST FLOWS

At minimum test:

## AUTH

- create/login user;
- expired session;
- unauthorised access;
- role separation.

## BOOKING

- booking succeeds;
- booking full;
- concurrent booking;
- cancellation;
- waitlist;
- invalid membership.

## MEMBERSHIP

- active;
- expired;
- insufficient entitlement.

## PAYMENT

- success;
- failure;
- cancelled;
- duplicate callback/event;
- server/client mismatch.

## TRAINING

- assigned programme;
- workout logging;
- history;
- AI adaptation.

## NUTRITION

- plan;
- daily tracking;
- AI context separation.

## COMMUNITY

- create post;
- report;
- block;
- moderation;
- access after removal.

## MARKETPLACE

- listing creation;
- moderation;
- purchase;
- sold state;
- invalid/duplicate transaction.

## AI

- course exists;
- course does not exist;
- insufficient context;
- hallucinated entity attempt;
- action requires confirmation;
- permission denied;
- malicious prompt trying to access another member.

---

# 43. ERROR DESIGN

The application must never expose raw backend errors to users.

Every critical operation requires states such as:

- loading;
- success;
- empty;
- unavailable;
- permission denied;
- recoverable error;
- non-recoverable error.

Example:

Not:

`PostgrestException...`

But:

**We couldn't complete your booking. The class may no longer be available.**

with a safe retry/refresh action.

---

# 44. PRIVACY

The platform potentially processes data relating to:

- identity;
- memberships;
- payments;
- workout activity;
- nutrition;
- user-generated content.

Privacy requirements must therefore be designed before production release.

The technical team must not invent legal retention periods, consent wording or health-data legal classifications.

These require appropriate product/legal validation for Italy/EU.

Engineering must nevertheless support:

- consent state where required;
- privacy preferences;
- account deletion workflow;
- controlled data access;
- data minimisation;
- auditability of privileged access.

---

# 45. OUT OF SCOPE

The following advanced functions are deliberately **NOT included in this release**:

- Apple Health integration;
- Google Health Connect integration;
- Garmin integration;
- WHOOP integration;
- wearable integrations;
- Apple Watch application;
- automatic sensor-based workout tracking;
- computer-vision exercise recognition;
- pose estimation;
- automatic repetition recognition;
- AI camera form correction;
- gym occupancy prediction;
- advanced biometric analysis;
- advanced health diagnostics;
- autonomous medical nutrition;
- advanced predictive performance modelling;
- complex AI autonomous agents outside the four defined AI modules.

Do not implement these unless the project owner explicitly changes scope.

---

# 46. REQUIRED USER EXPERIENCE

The complete application should allow a typical member to perform this scenario:

### 08:30

Open app.

See Daily:

**MEAL OF THE DAY**

See today's planned workout.

### 13:00

Ask:

> What can I do tonight?

AI Course Recommendation suggests an available Mobility class.

Member books.

### 18:00

Arrives at gym.

Opens TRAIN.

Starts workout.

Records exercises.

### 19:00

Attends booked class.

Booking/history updates.

### 20:30

Checks Nutrition.

Asks:

> I still need 35 g of protein. Give me some dinner ideas.

AI Nutrition Assistant answers according to authorised context.

### 21:00

Opens Community.

Sees another member selling training shoes.

Opens listing.

Purchases or contacts seller according to marketplace configuration.

The whole day occurs inside a **single digital gym ecosystem**.

---

# 47. PRODUCT SUCCESS CRITERIA

The product is successful only if it achieves all of the following:

### MEMBER

A member can manage their gym relationship without relying on reception for routine operations.

### BOOKING

Course discovery and booking are immediate.

### TRAINING

The training programme is an interactive system rather than a static document.

### NUTRITION

Nutrition is integrated into the member's daily activity.

### COMMUNITY

The application contains a reason to open it even when the member is not actively booking.

### DAILIES

At least 90 curated pieces of content exist at launch.

### MARKETPLACE

Gym and permitted members can publish sporting products inside the same community ecosystem.

### AI

AI materially assists users in exactly four areas:

- Course Recommendation;
- Training Adaptation;
- Nutrition Assistant;
- Gym Concierge.

### TECHNICAL

Security and business rules are enforced server-side.

### UX

The member experience feels like a modern consumer application, not a mobile ERP.

---

# 48. FINAL PRODUCT MAP

```text
                         GYM PLATFORM
                              │
        ┌─────────────────────┼──────────────────────┐
        │                     │                      │
      MEMBER                TRAINER               GYM
        │                     │                      │
        └─────────────────────┼──────────────────────┘
                              │
 ┌──────────┬──────────┬──────┴──────┬───────────┬────────────┐
 │          │          │             │           │            │
HOME      TRAIN       BOOK        COMMUNITY    PROFILE       AI
 │          │          │             │           │            │
Dailies   Workout    Courses       Feed        Member       Course
Today     Calendar   Sessions      Dailies     Payment      Training
Class     History    Waitlist      Market      Plans        Nutrition
Week      Progress                 Posts       Settings     Concierge
```

---

# 49. TECHNICAL FLOW

```text
Flutter iOS / Android
        │
        │ Supabase Auth Session
        ▼
Application / Repository Layer
        │
        ├──────────────► Supabase PostgreSQL
        │                    │
        │                    └── RLS
        │
        ├──────────────► Supabase Storage
        │
        ├──────────────► Supabase Realtime
        │
        └──────────────► Supabase Edge Functions
                              │
                              ├── Payment Gateway [TBD]
                              │
                              └── AI Gateway
                                      │
                                      ▼
                                GPT-5.6 Sol
```

---

# 50. NON-NEGOTIABLE IMPLEMENTATION RULES

1. **No OpenAI secrets in Flutter.**

2. **No payment trust in the client.**

3. **No booking-capacity trust in the client.**

4. **RLS required for private Supabase data.**

5. **AI cannot invent database entities.**

6. **AI cannot perform transaction-changing actions without server validation.**

7. **Sensitive AI actions require explicit member confirmation.**

8. **Community cannot ship without report/block/moderation.**

9. **Marketplace cannot ship without moderation.**

10. **Do not introduce unapproved providers.**

11. **Do not implement advanced/out-of-scope features.**

12. **Do not replace interactive workouts with PDF workout sheets.**

13. **Dailies library must contain at least 90 preloaded pieces of content before release.**

14. **Member UX and Admin UX must remain separated even if they share Flutter packages.**

15. **No requirement may be marked complete by the Auditor unless it is actually verified.**

---

# 51. DEFINITION OF DONE

The project is complete only when:

- Flutter iOS application passes functional testing;
- Flutter Android application passes functional testing;
- Club/Admin interface operates;
- Supabase migrations are reproducible;
- RLS audit passes;
- Auth works;
- Booking works;
- Waitlist works;
- courses work;
- calendar works;
- memberships work;
- approved payment integration works;
- workout plans work;
- workout logging works;
- nutrition works;
- minimum 90 Dailies are loaded;
- social/community works;
- moderation works;
- marketplace works;
- AI Course Recommendation works;
- AI Training Adaptation works;
- AI Nutrition Assistant works;
- AI Gym Concierge works;
- AI cannot bypass permissions;
- critical GitHub Actions tests pass;
- Claude Fable 5 produces no unresolved BLOCKER;
- release documentation is complete.

**END OF MASTER BRIEF**