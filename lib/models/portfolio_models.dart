import 'package:flutter/material.dart';

/// External profile link (GitHub, LinkedIn, etc.).
class SocialLink {
  const SocialLink({
    required this.label,
    required this.url,
    required this.icon,
  });

  final String label;
  final String url;
  final IconData icon;
}

/// Showcase project with optional repository and live demo URLs.
class Project {
  const Project({
    required this.title,
    required this.description,
    required this.tags,
    this.repoUrl,
    this.liveUrl,
  });

  final String title;
  final String description;
  final List<String> tags;
  final String? repoUrl;
  final String? liveUrl;
}

/// All copy and lists shown on the site — edit [PortfolioData.profile] to personalize.
class Profile {
  const Profile({
    required this.name,
    required this.role,
    required this.tagline,
    required this.about,
    required this.skills,
    required this.projects,
    required this.social,
    required this.email,
    this.phone,
    this.location,
    required this.avatarAssetPath,
  });

  final String name;
  final String role;
  final String tagline;
  final String about;
  final List<String> skills;
  final List<Project> projects;
  final List<SocialLink> social;
  final String email;

  /// E.164-style number for `tel:` links, e.g. +201019571031
  final String? phone;

  final String? location;

  /// Hero photo (declared in `pubspec.yaml` under `flutter.assets`).
  final String avatarAssetPath;
}
