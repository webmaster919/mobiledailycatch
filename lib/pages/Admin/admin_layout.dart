import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';

/// TGTG Business Style Admin Layout
class TGTGAdminLayout extends StatelessWidget {
  final Widget child;
  final String currentRoute;
  final String title;

  const TGTGAdminLayout({
    super.key,
    required this.child,
    required this.currentRoute,
    this.title = 'DailyCatch Business',
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Row(
        children: [
          // Sidebar (TGTG Business Style)
          if (isDesktop)
            Container(
              width: 260,
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Logo
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.greenTGTG,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.store,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'DailyCatch',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Menu
                  _buildMenuItem(context, 'dashboard', 'Aperçu', Icons.dashboard_outlined, '/admin/dashboard'),
                  _buildMenuItem(context, 'stores', 'Magasins', Icons.store_outlined, '/admin/partners'),
                  _buildMenuItem(context, 'orders', 'Commandes', Icons.shopping_bag_outlined, '/admin/orders'),
                  _buildMenuItem(context, 'clients', 'Clients', Icons.people_outline, '/admin/clients'),
                  _buildMenuItem(context, 'validations', 'Validations', Icons.verified_outlined, '/admin/partners/pending'),
                  _buildMenuItem(context, 'analytics', 'Analytiques', Icons.analytics_outlined, '/admin/analytics'),
                  const Spacer(),
                  const Divider(),
                  _buildMenuItem(context, 'settings', 'Paramètres', Icons.settings_outlined, '/admin/settings'),
                  _buildMenuItem(context, 'help', 'Aide', Icons.help_outline, '/admin/help'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          // Main content
          Expanded(
            child: Column(
              children: [
                // Top bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      if (!isDesktop)
                        Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ),
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: isDesktop ? 24 : 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Search
                      Container(
                        width: 280,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF7F7F7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Rechercher...',
                            prefixIcon: const Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Notifications
                      IconButton(
                        icon: Stack(
                          children: [
                            const Icon(Icons.notifications_outlined),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {},
                      ),
                      const SizedBox(width: 8),
                      // Profile
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.greenTGTG,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
      drawer: !isDesktop ? _buildMobileDrawer(context) : null,
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String id,
    String label,
    IconData icon,
    String route,
  ) {
    final isSelected = currentRoute.contains(id);
    final color = isSelected ? AppColors.greenTGTG : const Color(0xFF767676);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (currentRoute != route) {
            context.go(route);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 14),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.greenTGTG,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.store, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Text(
                  'DailyCatch Business',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildMobileMenuItem(context, 'dashboard', 'Aperçu', Icons.dashboard_outlined, '/admin/dashboard'),
          _buildMobileMenuItem(context, 'stores', 'Magasins', Icons.store_outlined, '/admin/partners'),
          _buildMobileMenuItem(context, 'orders', 'Commandes', Icons.shopping_bag_outlined, '/admin/orders'),
          _buildMobileMenuItem(context, 'clients', 'Clients', Icons.people_outlined, '/admin/clients'),
          _buildMobileMenuItem(context, 'validations', 'Validations', Icons.verified_outlined, '/admin/partners/pending'),
          const Spacer(),
          _buildMobileMenuItem(context, 'settings', 'Paramètres', Icons.settings_outlined, '/admin/settings'),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildMobileMenuItem(
    BuildContext context,
    String id,
    String label,
    IconData icon,
    String route,
  ) {
    final isSelected = currentRoute.contains(id);

    return ListTile(
      leading: Icon(icon, color: isSelected ? AppColors.greenTGTG : Colors.grey),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected ? AppColors.greenTGTG : Colors.black,
        ),
      ),
      onTap: () {
        context.pop();
        context.go(route);
      },
    );
  }
}
