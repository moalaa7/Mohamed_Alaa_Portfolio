import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../models/portfolio_models.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!mounted || ok) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not open link: $url')),
    );
  }

  Future<void> _openEmail(String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    await _openUrl(uri.toString());
  }

  Future<void> _openTel(String phone) async {
    final normalized = phone.replaceAll(RegExp(r'\s'), '');
    final uri = Uri.tryParse('tel:$normalized');
    if (uri == null) return;
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!mounted || ok) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not start call: $phone')),
    );
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutCubic,
      alignment: 0.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = PortfolioData.profile;
    final scheme = Theme.of(context).colorScheme;
    final wide = MediaQuery.sizeOf(context).width >= 800;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          p.name,
          style: const TextStyle(fontWeight: FontWeight.w600, letterSpacing: -0.2),
        ),
        actions: [
          if (wide) ...[
            TextButton(onPressed: () => _scrollTo(_aboutKey), child: const Text('About')),
            TextButton(onPressed: () => _scrollTo(_skillsKey), child: const Text('Skills')),
            TextButton(onPressed: () => _scrollTo(_projectsKey), child: const Text('Projects')),
            TextButton(onPressed: () => _scrollTo(_contactKey), child: const Text('Contact')),
            const SizedBox(width: 8),
          ],
        ],
      ),
      drawer: wide
          ? null
          : Drawer(
              child: SafeArea(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: const Text('About'),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_aboutKey);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.bolt_outlined),
                      title: const Text('Skills'),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_skillsKey);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.folder_outlined),
                      title: const Text('Projects'),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_projectsKey);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.mail_outline),
                      title: const Text('Contact'),
                      onTap: () {
                        Navigator.pop(context);
                        _scrollTo(_contactKey);
                      },
                    ),
                  ],
                ),
              ),
            ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 920),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _HeroSection(
                        key: _heroKey,
                        profile: p,
                        scheme: scheme,
                        onPrimary: _openEmail,
                        onViewWork: () => _scrollTo(_projectsKey),
                      ),
                      const SizedBox(height: 56),
                      _Section(
                        key: _aboutKey,
                        title: 'About',
                        child: Text(
                          p.about,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                height: 1.55,
                                color: scheme.onSurface.withValues(alpha: 0.88),
                              ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      _Section(
                        key: _skillsKey,
                        title: 'Skills',
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for (final s in p.skills)
                              Chip(
                                label: Text(s),
                                visualDensity: VisualDensity.compact,
                                side: BorderSide(color: scheme.outline.withValues(alpha: 0.35)),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 48),
                      _Section(
                        key: _projectsKey,
                        title: 'Projects',
                        child: Column(
                          children: [
                            for (final project in p.projects) ...[
                              _ProjectCard(project: project, onOpenUrl: _openUrl),
                              const SizedBox(height: 16),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      _Section(
                        key: _contactKey,
                        title: 'Contact',
                        child: _ContactBlock(
                          profile: p,
                          onOpenUrl: _openUrl,
                          onEmail: _openEmail,
                          onTel: _openTel,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Built with Flutter',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: scheme.onSurface.withValues(alpha: 0.45),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: scheme.primary,
              ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}

/// Breakpoint for photo + text in a [Row]; below this, photo is centered above copy.
const double _kHeroPhotoRowMinWidth = 640;

class _HeroSection extends StatelessWidget {
  const _HeroSection({
    super.key,
    required this.profile,
    required this.scheme,
    required this.onPrimary,
    required this.onViewWork,
  });

  final Profile profile;
  final ColorScheme scheme;
  final void Function(String email) onPrimary;
  final VoidCallback onViewWork;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final asset = profile.avatarAssetPath;

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= _kHeroPhotoRowMinWidth;
        return _buildHero(context, textTheme, asset, wide);
      },
    );
  }

  Widget _buildHero(
    BuildContext context,
    TextTheme textTheme,
    String asset,
    bool wide,
  ) {

    Widget textColumn() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            profile.role,
            style: textTheme.titleMedium?.copyWith(
              color: scheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            profile.name,
            style: textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
              height: 1.05,
            ),
          ),
          const SizedBox(height: 8),
          if (profile.location != null) ...[
            Row(
              children: [
                Icon(
                  Icons.place_outlined,
                  size: 18,
                  color: scheme.onSurface.withValues(alpha: 0.55),
                ),
                const SizedBox(width: 6),
                Text(
                  profile.location!,
                  style: textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurface.withValues(alpha: 0.68),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ] else
            const SizedBox(height: 8),
          Text(
            profile.tagline,
            style: textTheme.bodyLarge?.copyWith(
              height: 1.5,
              color: scheme.onSurface.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () => onPrimary(profile.email),
                icon: const Icon(Icons.mail_outline, size: 20),
                label: const Text('Email me'),
              ),
              OutlinedButton.icon(
                onPressed: onViewWork,
                icon: const Icon(Icons.folder_outlined, size: 20),
                label: const Text('View work'),
              ),
            ],
          ),
        ],
      );
    }

    final r = wide ? 72.0 : 60.0;
    final avatar = ClipOval(
      child: Image.asset(
        asset,
        width: r * 2,
        height: r * 2,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => ColoredBox(
          color: scheme.primary.withValues(alpha: 0.12),
          child: Icon(Icons.person, size: r * 1.1, color: scheme.primary),
        ),
      ),
    );

    if (wide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          avatar,
          const SizedBox(width: 28),
          Expanded(child: textColumn()),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: avatar),
        const SizedBox(height: 24),
        textColumn(),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project, required this.onOpenUrl});

  final Project project;
  final Future<void> Function(String url) onOpenUrl;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              project.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.45,
                    color: scheme.onSurface.withValues(alpha: 0.82),
                  ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final t in project.tags)
                  Chip(
                    label: Text(t),
                    visualDensity: VisualDensity.compact,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: BorderSide(color: scheme.outline.withValues(alpha: 0.25)),
                  ),
              ],
            ),
            if (project.liveUrl != null || project.repoUrl != null) ...[
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (project.liveUrl != null)
                    FilledButton.tonalIcon(
                      onPressed: () => onOpenUrl(project.liveUrl!),
                      icon: const Icon(Icons.open_in_new, size: 18),
                      label: const Text('Live'),
                    ),
                  if (project.repoUrl != null)
                    OutlinedButton.icon(
                      onPressed: () => onOpenUrl(project.repoUrl!),
                      icon: const Icon(Icons.code, size: 18),
                      label: const Text('Code'),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ContactBlock extends StatelessWidget {
  const _ContactBlock({
    required this.profile,
    required this.onOpenUrl,
    required this.onEmail,
    required this.onTel,
  });

  final Profile profile;
  final Future<void> Function(String url) onOpenUrl;
  final void Function(String email) onEmail;
  final void Function(String phone) onTel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Open to Flutter developer roles — remote or hybrid. Based in Alexandria, Egypt.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.5,
                color: scheme.onSurface.withValues(alpha: 0.85),
              ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            ActionChip(
              avatar: Icon(Icons.mail_outline, size: 18, color: scheme.primary),
              label: Text(profile.email),
              onPressed: () => onEmail(profile.email),
            ),
            if (profile.phone != null)
              ActionChip(
                avatar: Icon(Icons.phone_outlined, size: 18, color: scheme.primary),
                label: Text(profile.phone!),
                onPressed: () => onTel(profile.phone!),
              ),
            for (final link in profile.social)
              ActionChip(
                avatar: Icon(link.icon, size: 18, color: scheme.primary),
                label: Text(link.label),
                onPressed: () => onOpenUrl(link.url),
              ),
          ],
        ),
      ],
    );
  }
}
