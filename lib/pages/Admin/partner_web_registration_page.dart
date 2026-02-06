import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';

/// Partner Registration Web Page - TGTG Style
/// Interface web pour l'inscription des commerçants
class PartnerWebRegistrationPage extends StatefulWidget {
  const PartnerWebRegistrationPage({super.key});

  @override
  State<PartnerWebRegistrationPage> createState() =>
      _PartnerWebRegistrationPageState();
}

class _PartnerWebRegistrationPageState
    extends State<PartnerWebRegistrationPage> {
  final TextEditingController _storeSearchController = TextEditingController();
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ownerNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _selectedCategory = 'Poissonnerie';
  bool _agreedToTerms = false;
  bool _isLoading = false;

  final List<String> _categories = [
    'Poissonnerie',
    'Fruits de mer',
    'Crustacés',
    'Coquillages',
    'Restauration',
    'Epicerie',
  ];

  // Mock store suggestions
  final List<Map<String, dynamic>> _storeSuggestions = [
    {
      'name': 'DailyCatch Store',
      'address': '15 Rue du Port, Dakar',
      'category': 'Poissonnerie',
    },
    {
      'name': 'Poissonnerie du Port',
      'address': '28 Avenue de la Plage, Dakar',
      'category': 'Fruits de mer',
    },
    {
      'name': 'Ocean Fresh',
      'address': '42 Quai des Pêcheurs, Dakar',
      'category': 'Poissonnerie',
    },
  ];

  List<Map<String, dynamic>> get _filteredSuggestions {
    if (_storeSearchController.text.isEmpty) return [];
    return _storeSuggestions.where((store) {
      return store['name'].toString().toLowerCase().contains(
        _storeSearchController.text.toLowerCase(),
      );
    }).toList();
  }

  void _selectStore(Map<String, dynamic> store) {
    _storeNameController.text = store['name'] as String;
    _addressController.text = store['address'] as String;
    _selectedCategory = store['category'] as String;
    setState(() {});
  }

  void _submitRegistration() {
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez accepter les conditions générales'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Demande de partenariat soumise avec succès!'),
            backgroundColor: AppColors.greenTGTG,
          ),
        );
        context.go('/admin/partners/pending');
      }
    });
  }

  @override
  void dispose() {
    _storeSearchController.dispose();
    _storeNameController.dispose();
    _addressController.dispose();
    _ownerNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      body: Center(
        child: Container(
          width: isDesktop ? 600 : double.infinity,
          margin: const EdgeInsets.all(24),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo and Title
                  Center(
                    child: Column(
                      children: [
                        // Logo placeholder
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.blueBic,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.store,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Inscrivez votre commerce',
                          style: GoogleFonts.poppins(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Identifions votre commerce et commençons votre inscription. '
                          'Cela ne prendra que quelques minutes !',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Store Search
                  Text(
                    'Recherchez le nom du commerce',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _storeSearchController,
                    decoration: InputDecoration(
                      hintText: 'Nom de votre commerce...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.blueBic,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (value) => setState(() {}),
                  ),

                  // Suggestions
                  if (_filteredSuggestions.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children:
                            _filteredSuggestions.map((store) {
                              return ListTile(
                                leading: const Icon(
                                  Icons.store,
                                  color: AppColors.blueBic,
                                ),
                                title: Text(
                                  store['name'] as String,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  store['address'] as String,
                                  style: GoogleFonts.poppins(fontSize: 12),
                                ),
                                onTap: () => _selectStore(store),
                              );
                            }).toList(),
                      ),
                    ),
                  const SizedBox(height: 24),

                  // Store Name
                  _buildTextField(
                    controller: _storeNameController,
                    label: 'Nom du commerce',
                    hint: 'Le nom de votre boutique',
                    icon: Icons.store,
                  ),
                  const SizedBox(height: 16),

                  // Address
                  _buildTextField(
                    controller: _addressController,
                    label: 'Adresse',
                    hint: 'Adresse complète',
                    icon: Icons.location_on,
                  ),
                  const SizedBox(height: 16),

                  // Category Dropdown
                  _buildDropdownField(),
                  const SizedBox(height: 24),

                  // Owner Info Section
                  Text(
                    'Vos informations',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Owner Name
                  _buildTextField(
                    controller: _ownerNameController,
                    label: 'Nom du gérant',
                    hint: 'Votre nom complet',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 16),

                  // Email
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'email@exemple.com',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Phone
                  _buildTextField(
                    controller: _phoneController,
                    label: 'Téléphone',
                    hint: '+221 XX XXX XXXX',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),

                  // Password
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Mot de passe',
                    hint: '最小 8 caractères',
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),

                  // Terms Checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: _agreedToTerms,
                        onChanged: (value) {
                          setState(() => _agreedToTerms = value!);
                        },
                        activeColor: AppColors.blueBic,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'En poursuivant, vous acceptez la '
                          'Politique de confidentialité et les '
                          'Conditions générales d\'utilisation de DailyCatch.',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submitRegistration,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueBic,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child:
                          _isLoading
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                              : Text(
                                'Commencer l\'inscription',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Login Link
                  Center(
                    child: TextButton(
                      onPressed: () => context.push('/admin/login'),
                      child: Text(
                        'Vous avez déjà un compte commerçant ? '
                        'Connectez-vous',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.blueBic,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.blueBic, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catégorie',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.category, color: Colors.grey),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items:
                _categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category, style: GoogleFonts.poppins()),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() => _selectedCategory = value!);
            },
          ),
        ),
      ],
    );
  }
}
