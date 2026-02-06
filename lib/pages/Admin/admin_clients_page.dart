import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/pages/Admin/admin_layout.dart';

/// Clients Management Page - Web Style TGTG
class AdminClientsPage extends StatefulWidget {
  const AdminClientsPage({super.key});

  @override
  State<AdminClientsPage> createState() => _AdminClientsPageState();
}

class _AdminClientsPageState extends State<AdminClientsPage> {
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  // Mock data for clients
  final List<Map<String, dynamic>> _clients = [
    {
      'id': 'C001',
      'name': 'Ibrahima Aidara',
      'email': 'ibrahima@email.com',
      'phone': '+221 77 123 45 67',
      'ordersCount': 12,
      'totalSpent': 156.50,
      'savedCO2': 15.2,
      'joinedDate': DateTime.now().subtract(const Duration(days: 120)),
      'status': 'active',
    },
    {
      'id': 'C002',
      'name': 'Fatou Sall',
      'email': 'fatou@email.com',
      'phone': '+221 77 234 56 78',
      'ordersCount': 8,
      'totalSpent': 98.75,
      'savedCO2': 10.5,
      'joinedDate': DateTime.now().subtract(const Duration(days: 90)),
      'status': 'active',
    },
    {
      'id': 'C003',
      'name': 'Mamadou Diop',
      'email': 'mamadou@email.com',
      'phone': '+221 77 345 67 89',
      'ordersCount': 24,
      'totalSpent': 312.00,
      'savedCO2': 28.9,
      'joinedDate': DateTime.now().subtract(const Duration(days: 180)),
      'status': 'active',
    },
    {
      'id': 'C004',
      'name': 'Aissatou Diallo',
      'email': 'aissatou@email.com',
      'phone': '+221 77 456 78 90',
      'ordersCount': 3,
      'totalSpent': 42.50,
      'savedCO2': 4.2,
      'joinedDate': DateTime.now().subtract(const Duration(days: 30)),
      'status': 'active',
    },
    {
      'id': 'C005',
      'name': 'Cheikh Ndiaye',
      'email': 'cheikh@email.com',
      'phone': '+221 77 567 89 01',
      'ordersCount': 0,
      'totalSpent': 0,
      'savedCO2': 0,
      'joinedDate': DateTime.now().subtract(const Duration(days: 5)),
      'status': 'new',
    },
  ];

  List<Map<String, dynamic>> get _filteredClients {
    List<Map<String, dynamic>> result = [..._clients];

    if (_selectedTab == 1) {
      result = result.where((c) => c['status'] == 'new').toList();
    } else if (_selectedTab == 2) {
      result = result.where((c) => (c['ordersCount'] as int) > 10).toList();
    }

    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      result = result.where((c) {
        return (c['name'] as String).toLowerCase().contains(query) ||
               (c['email'] as String).toLowerCase().contains(query);
      }).toList();
    }

    return result;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TGTGAdminLayout(
      currentRoute: '/admin/clients',
      title: 'Clients',
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gestion des clients',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_filteredClients.length} clients',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Stats Cards
            Row(
              children: [
                Expanded(child: _buildStatCard('Total clients', _clients.length.toString(), Icons.people, AppColors.blueBic)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('Nouveaux (30j)', '12', Icons.person_add, Colors.green)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('Commandes totales', '256', Icons.shopping_bag, Colors.orange)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('CO₂ sauvé', '58.8kg', Icons.eco, Colors.purple)),
              ],
            ),
            const SizedBox(height: 24),

            // Filters
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[200]!),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Rechercher un client...',
                            prefixIcon: const Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onChanged: (value) => setState(() {}),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          _buildTabButton('Tous', 0),
                          _buildTabButton('Nouveaux', 1),
                          _buildTabButton('Actifs', 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Clients Table
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[200]!),
              ),
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Client')),
                    DataColumn(label: Text('Contact')),
                    DataColumn(label: Text('Commandes')),
                    DataColumn(label: Text('Dépensé')),
                    DataColumn(label: Text('CO₂ sauvé')),
                    DataColumn(label: Text('Inscrit le')),
                    DataColumn(label: Text('')),
                  ],
                  rows: _filteredClients.map((client) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.blueBic.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.blueBic,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                client['name'] as String,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                client['email'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                client['phone'] as String,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        DataCell(
                          Text((client['ordersCount'] as int).toString()),
                        ),
                        DataCell(
                          Text(
                            '${client['totalSpent']}€',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              const Icon(Icons.eco, color: Colors.green, size: 16),
                              const SizedBox(width: 4),
                              Text('${client['savedCO2']}kg'),
                            ],
                          ),
                        ),
                        DataCell(
                          Text(
                            '${client['joinedDate'].day}/${client['joinedDate'].month}/${client['joinedDate'].year}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  title,
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
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = _selectedTab == index;
    return MaterialButton(
      onPressed: () => setState(() => _selectedTab = index),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected ? AppColors.blueBic : Colors.grey[700],
        ),
      ),
    );
  }
}
