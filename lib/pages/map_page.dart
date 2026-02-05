import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/widgets/bottom_nav_bar.dart';

/// Page Map - Carte des boutiques à proximité - Clone TGTG
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  String _selectedCategory = 'Tous';

  final List<String> _categories = [
    'Tous',
    'Poisson',
    'Fruits de mer',
    'Crustacés',
  ];

  // Boutiques avec coordonnées (Dakar)
  final List<Map<String, dynamic>> _stores = [
    {
      'id': '1',
      'name': 'DailyCatch Store',
      'category': 'Poissonnerie',
      'lat': 14.6928,
      'lng': -17.4467,
      'distance': '0.5 km',
      'price': 4.99,
      'originalPrice': 15.00,
      'rating': 4.5,
      'products': 3,
    },
    {
      'id': '2',
      'name': 'Poissonnerie du Port',
      'category': 'Fruits de mer',
      'lat': 14.6935,
      'lng': -17.4440,
      'distance': '0.8 km',
      'price': 6.99,
      'originalPrice': 20.00,
      'rating': 4.8,
      'products': 5,
    },
    {
      'id': '3',
      'name': 'Ocean Fresh',
      'category': 'Poisson',
      'lat': 14.6900,
      'lng': -17.4500,
      'distance': '1.2 km',
      'price': 5.49,
      'originalPrice': 18.00,
      'rating': 4.2,
      'products': 4,
    },
    {
      'id': '4',
      'name': 'Le Marché de la Mer',
      'category': 'Crustacés',
      'lat': 14.6950,
      'lng': -17.4420,
      'distance': '1.5 km',
      'price': 7.99,
      'originalPrice': 22.00,
      'rating': 4.6,
      'products': 2,
    },
  ];

  List<Map<String, dynamic>> get _filteredStores {
    if (_selectedCategory == 'Tous') return _stores;
    return _stores.where((s) => s['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Boutiques à proximité',
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location, color: AppColors.blueBic),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          // Categories filter
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? AppColors.blueBic : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        category,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Map placeholder
          Expanded(
            child: Stack(
              children: [
                // Carte simulée (comme TGTG)
                Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.map, size: 80, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          'Carte des boutiques',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Dakar, Sénégal',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '${_filteredStores.length} boutiques à proximité',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.blueBic,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Store markers
                ..._filteredStores.asMap().entries.map((entry) {
                  final store = entry.value;
                  return _buildStoreMarker(context, store, entry.key);
                }),
                // List toggle button
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () => _showStoresSheet(context),
                      icon: const Icon(Icons.list, color: Colors.black),
                      label: Text(
                        'Voir les boutiques (${_filteredStores.length})',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildStoreMarker(
    BuildContext context,
    Map<String, dynamic> store,
    int index,
  ) {
    // Position simulée des marqueurs sur la carte
    final positions = [
      {'top': 100.0, 'left': 50.0},
      {'top': 150.0, 'right': 80.0},
      {'bottom': 150.0, 'left': 100.0},
      {'bottom': 120.0, 'right': 50.0},
    ];
    final pos = positions[index % positions.length];

    return Positioned(
      top: pos['top'],
      left: pos['left'],
      right: pos['right'],
      bottom: pos['bottom'],
      child: GestureDetector(
        onTap: () {
          context.push('/store/${store['id']}', extra: store);
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.blueBic,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.store, color: Colors.white, size: 24),
              Text(
                store['price'].toStringAsFixed(2) + '€',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showStoresSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder:
          (context) => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Boutiques à proximité (${_filteredStores.length})',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredStores.length,
                    itemBuilder: (context, index) {
                      final store = _filteredStores[index];
                      return _buildStoreListItem(context, store);
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildStoreListItem(BuildContext context, Map<String, dynamic> store) {
    final discount =
        ((store['originalPrice'] - store['price']) /
                store['originalPrice'] *
                100)
            .round();

    return GestureDetector(
      onTap: () {
        context.pop();
        context.push('/store/${store['id']}', extra: store);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.blueBic,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.store, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store['name'] as String,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        store['distance'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        store['rating'].toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  store['price'].toStringAsFixed(2) + '€',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blueBic,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '-$discount%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: AppColors.blueBic),
            accountName: Text(
              'Ibrahima Aidara',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              'ibrahima@email.com',
              style: GoogleFonts.poppins(),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: AppColors.blueBic),
            ),
          ),
          _buildDrawerItem(Icons.map, 'Carte', '/map'),
          _buildDrawerItem(Icons.qr_code_2, 'Mes sauvés', '/pickup'),
          _buildDrawerItem(Icons.person, 'Mon profil', '/profile'),
          _buildDrawerItem(Icons.settings, 'Paramètres', '/settings'),
          const Divider(),
          _buildDrawerItem(Icons.help, 'Aide & FAQ', '/help'),
          _buildDrawerItem(Icons.logout, 'Déconnexion', '/login'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: AppColors.blueBic),
      title: Text(title, style: GoogleFonts.poppins()),
      onTap: () {
        context.pop();
        context.push(route);
      },
    );
  }
}
