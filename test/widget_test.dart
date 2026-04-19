import 'package:flutter_test/flutter_test.dart';

import 'package:mohamed_alaa_portfolio/main.dart';
import 'package:mohamed_alaa_portfolio/data/portfolio_data.dart';

void main() {
  testWidgets('Portfolio shows profile name and role', (WidgetTester tester) async {
    await tester.pumpWidget(const PortfolioApp());

    expect(find.text(PortfolioData.profile.name), findsWidgets);
    expect(find.text(PortfolioData.profile.role), findsOneWidget);
    expect(find.textContaining('Projects'), findsWidgets);
  });
}
