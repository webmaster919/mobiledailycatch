import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/pages/Admin/admin_layout.dart';

/// Partners Management Page - Web Style TGTG
class AdminPartnersPage extends StatefulWidget {
  const AdminPartnersPage({super.key});

  @override
  State<AdminPartnersPage> createState() => _AdminPartnersPageState();
}

class _AdminPartnersPageState extends State<AdminPartnersPage> {
  int _selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();

  // Mock data for partners
  final List<Map<String, dynamic>> _partners = [
    {
      'id': 'P001',
      'name': 'DailyCatch Store',
      'owner': 'Ibrahima Aidara',
      'category': 'Poissonnerie',
      'email': 'contact@dailycatch.com',
      'phone': '+221 77 123 45 67',
      'address': '15 Rue du Port, Dakar',
      'status': 'active',
      'rating': 4.5,
      'ordersCount': 245,
      'revenue': 12500.50,
      'joinedDate': DateTime.now().subtract(const Duration(days: 60)),
    },
    {
      'id': 'P002',
      'name': 'Poissonnerie du Port',
      'owner': 'Mamadou Diop',
      'category': 'Fruits de mer',
      'email': 'contact@portpoisson.com',
      'phone': '+221 77 234 56 78',
      'address': '28 Avenue de la Plage, Dakar',
      'status': 'active',
      'rating': 4.8,
      'ordersCount': 189,
      'revenue': 9800.25,
      'joinedDate': DateTime.now().subtract(const Duration(days: 45)),
    },
    {
      'id': 'P003',
      'name': 'Ocean Fresh',
      'owner': 'Fatou Sall',
      'category': 'Poisson',
      'email': 'hello@oceanfresh.sn',
      'phone': '+221 77 345 67 89',
      'address': '42 Quai des Pêcheurs',
      'status': 'pending',
      'rating': 0,
      'ordersCount': 0,
      'revenue': 0,
      'joinedDate': DateTime.now().subtract(const Duration(days: 3)),
    },
    {
      'id': 'P004',
      'name': 'Le Marché de la Mer',
      'owner': 'Cheikh Ndiaye',
      'category': 'Crustacés',
      'email': 'info@marchemer.sn',
      'phone': '+221 77 456 78 90',
      'address': '10 Boulevard de la Corniche',
      'status': 'active',
      'rating': 4.2,
      'ordersCount': 156,
      'revenue': 7650.00,
      'joinedDate': DateTime.now().subtract(const Duration(days: 30)),
    },
    {
      'id': 'P005',
      'name': 'Coquillages & Crustacés',
      'owner': 'Aissatou Diallo',
      'category': 'Coquillages',
      'email': 'contact@coquillages.sn',
      'phone': '+221 77 567 89 01',
      'address': '55 Rue des Coquillages',
      'status': 'inactive',
      'rating': 4.0,
      'ordersCount': 89,
      'revenue': 4200.75,
      'joinedDate': DateTime.now().subtract(const Duration(days: 90)),
    },
  ];

  List<Map<String, dynamic>> get _filteredPartners {
    List<Map<String, dynamic>> result = [..._partners];

    // Filter by tab
    if (_selectedTab == 1) {
      result = result.where((p) => p['status'] == 'active').toList();
    } else if (_selectedTab == 2) {
      result = result.where((p) => p['status'] == 'pending').toList();
    } else if (_selectedTab == 3) {
      result = result.where((p) => p['status'] == 'inactive').toList();
    }

    // Filter by search
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      result = result.where((p) {
        return (p['name'] as String).toLowerCase().contains(query) ||
               (p['owner'] as String).toLowerCase().contains(query) ||
               (p['email'] as String).toLowerCase().contains(query);
      }).toList();
    }

    return result;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'active':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'inactive':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  String _getStatusLabel(String status) {
    switch (status) {
      case 'active':
        return 'Actif';
      case 'pending':
        return 'En attente';
      case 'inactive':
        return 'Inactif';
      default:
        return status;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TGTGAdminLayout(
      currentRoute: '/admin/partners',
      title: 'Partenaires',
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
                      'Gestion des partenaires',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${_filteredPartners.length} partenaires',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () => context.go('/admin/register-web'),
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: Text(
                    'Ajouter',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueBic,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
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
                    // Search
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Rechercher un partenaire...',
                            prefixIcon: const Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onChanged: (value) => setState(() {}),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Status tabs
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          _buildTabButton('Tous', 0),
                          _buildTabButton('Actifs', 1),
                          _buildTabButton('En attente', 2),
                          _buildTabButton('Inactifs', 3),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Partners Table
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey[200]!),
              ),
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Partenaire')),
                    DataColumn(label: Text('Catégorie')),
                    DataColumn(label: Text('Statut')),
                    DataColumn(label: Text('Note')),
                    DataColumn(label: Text('Commandes')),
                    DataColumn(label: Text('Revenus')),
                    DataColumn(label: Text('')),
                  ],
                  rows: _filteredPartners.map((partner) {
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
                                  Icons.store,
                                  color: AppColors.blueBic,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    partner['name'] as String,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    partner['email'] as String,
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
                        DataCell(
                          Text(
                            partner['category'] as String,
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getStatusColor(partner['status'] as String).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _getStatusLabel(partner['status'] as String),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getStatusColor(partner['status'] as String),
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Row(
                            children: [
                              const Icon(Icons.star, color: Color(0xFFFFB800), size: 16),
                              const SizedBox(width: 4),
                              Text(partner['rating'].toString()),
                            ],
                          ),
                        ),
                        DataCell(
                          Text((partner['ordersCount'] as int).toString()),
                        ),
                        DataCell(
                          Text(
                            '${partner['revenue']}€',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
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
