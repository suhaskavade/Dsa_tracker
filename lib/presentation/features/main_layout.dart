import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dsa_tracker/core/theme/app_colors.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 800;

    return Scaffold(
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(context),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar: !isDesktop ? _buildBottomNav(context) : null,
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Container(
      width: 250,
      color: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const SizedBox(height: 32),
          Text('DSA Tracker', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 32),
          _SidebarItem(
            icon: Icons.dashboard,
            title: 'Dashboard',
            route: '/dashboard',
          ),
          _SidebarItem(icon: Icons.map, title: 'Roadmap', route: '/roadmap'),
          _SidebarItem(
            icon: Icons.list_alt,
            title: 'Questions',
            route: '/questions',
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _calculateSelectedIndex(context),
      onTap: (index) => _onItemTapped(index, context),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Roadmap'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Questions'),
      ],
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/roadmap')) return 1;
    if (location.startsWith('/questions')) return 2;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/roadmap');
        break;
      case 2:
        context.go('/questions');
        break;
    }
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const _SidebarItem({
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = GoRouterState.of(context).uri.path.startsWith(route);
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.darkPrimary : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.darkPrimary : Colors.grey,
        ),
      ),
      selected: isSelected,
      onTap: () => context.go(route),
    );
  }
}
