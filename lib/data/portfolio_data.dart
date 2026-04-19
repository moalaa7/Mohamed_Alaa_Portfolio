import 'package:flutter/material.dart';

import '../models/portfolio_models.dart';

/// Central place to update your portfolio content.
class PortfolioData {
  PortfolioData._();

  static const Profile profile = Profile(
    name: 'Mohamed Alaa',
    role: 'Flutter Developer',
    location: 'Alexandria, Egypt',
    avatarAssetPath: 'assets/images/mohamed alaa.jpeg',
    tagline:
        'Scalable mobile apps with Flutter, Firebase, and Clean Architecture — '
        'MVVM, repositories, REST APIs, and state management with Provider & BLoC.',
    about:
        'Flutter developer specializing in scalable mobile applications using Flutter, '
        'Firebase, and Clean Architecture. Experienced in MVVM, the repository pattern, '
        'REST API integration, and state management (Provider and BLoC). I care about '
        'performance, maintainable code, and smooth user experiences.\n\n'
        'Education: B.Sc. in Computers and Data Sciences, Data Science — Alexandria '
        'University, Faculty of Computer and Data Science (09/2021 – 06/2025), GPA 3.04/4 '
        '(Very Good).\n\n'
        'Certificates: AI — My Communication Academy summer training (2023); '
        'Flutter & Dart — IRI summer training (2024); Flutter Development Diploma — '
        'Route IT Training Centre (2025).\n\n'
        'Languages: Arabic (native), English.',
    skills: [
      'Dart',
      'Python',
      'SQL',
      'Flutter',
      'Firebase',
      'Git',
      'VS Code',
      'MVVM',
      'Repository pattern',
      'Clean Architecture',
      'REST APIs',
      'OOP',
      'Provider',
      'BLoC',
      'Responsive UI',
    ],
    projects: [
      Project(
        title: 'E-Commerce App',
        description:
            'End-to-end shopping flow: catalog, cart, and checkout. Scalable MVVM + '
            'repository architecture, Firebase Authentication and real-time storage, '
            'payment simulation, and robust state management.',
        tags: ['Flutter', 'Firebase', 'MVVM', 'Clean Architecture'],
      ),
      Project(
        title: 'Evently App',
        description:
            'Event management with full CRUD, Firebase Auth and Firestore, multi-language '
            'support, category filtering, and Provider-based state management.',
        tags: ['Flutter', 'Firebase', 'Provider', 'i18n'],
      ),
      Project(
        title: 'News App',
        description:
            'REST API integration for real-time news, filtering and search, solid error '
            'handling, and asynchronous UI with FutureBuilder.',
        tags: ['Flutter', 'REST', 'FutureBuilder'],
      ),
      Project(
        title: 'Islamy App',
        description:
            'Islamic app experience: Quran, Hadith, prayer times, and radio — with '
            'localization, dark theme, and responsive layouts.',
        tags: ['Flutter', 'Localization', 'Theming'],
        repoUrl: 'https://github.com/moalaa7/Islamy-App',
      ),
    ],
    social: [
      SocialLink(
        label: 'GitHub',
        url: 'https://github.com/moalaa7',
        icon: Icons.code,
      ),
      SocialLink(
        label: 'LinkedIn',
        url: 'https://www.linkedin.com/in/mohamed-alaa-9167a6230',
        icon: Icons.work_outline,
      ),
    ],
    email: 'mohamedalaa0257@gmail.com',
    phone: '+201019571031',
  );
}
