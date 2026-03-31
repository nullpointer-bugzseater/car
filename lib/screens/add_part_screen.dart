import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants.dart';
import '../widgets/widgets.dart';

class AddPartScreen extends StatefulWidget {
  const AddPartScreen({super.key});

  @override
  State<AddPartScreen> createState() => _AddPartScreenState();
}

class _AddPartScreenState extends State<AddPartScreen> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _sellerController = TextEditingController();
  final _conditionController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitPart() async {
    if (_nameController.text.isEmpty || _priceController.text.isEmpty || _sellerController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      await FirebaseFirestore.instance.collection('parts').add({
        'name': _nameController.text.trim(),
        'price': double.tryParse(_priceController.text.trim()) ?? 0.0,
        'sellerName': _sellerController.text.trim(),
        'condition': _conditionController.text.trim().isEmpty ? 'Used' : _conditionController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Part listed successfully!')));
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to list part')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _sellerController.dispose();
    _conditionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Sell a Part', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Part Details',
              subtitle: 'List your spare part in the marketplace',
            ),
            const SizedBox(height: 32),
            AppTextField(
              controller: _nameController,
              label: 'Part Name *',
              hint: 'e.g. Brembo Brake Pads',
              icon: Icons.settings_suggest,
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: _priceController,
              label: 'Price (LKR) *',
              hint: 'e.g. 15000',
              icon: Icons.attach_money,
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: _sellerController,
              label: 'Seller/Shop Name *',
              hint: 'e.g. AutoZone SL',
              icon: Icons.storefront,
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: _conditionController,
              label: 'Condition',
              hint: 'e.g. New or Used',
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 48),
            _isLoading
                ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                : AppButton(
                    text: 'Publish Listing',
                    onPressed: _submitPart,
                  ),
          ],
        ),
      ),
    );
  }
}
