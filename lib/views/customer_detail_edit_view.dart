import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/customer_model.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/popup_delete_customer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomerEditView extends StatefulWidget {
  final CustomerModel customer;

  const CustomerEditView({super.key, required this.customer});

  @override
  State<CustomerEditView> createState() => _CustomerEditPageState();
}

class _CustomerEditPageState extends State<CustomerEditView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _dobController;

  File? _avatarFile;

  final ImagePicker _picker = ImagePicker();
  String gender = "Male";

  DateTime? selectedDob;

  @override
  void initState() {
    super.initState();
    final c = widget.customer;
    _nameController = TextEditingController(text: c.name);
    _phoneController = TextEditingController(text: c.phoneNumber);
    _emailController = TextEditingController(text: c.email);
    if (c.dob != null && c.dob!.isNotEmpty) {
      try {
        selectedDob = DateFormat('dd/MM/yyyy').parseStrict(c.dob!);
      } catch (e) {
        selectedDob = null;
      }
    } else {
      selectedDob = null;
    }

    _dobController = TextEditingController(
      text: selectedDob != null
          ? DateFormat('dd/MM/yyyy').format(selectedDob!)
          : '',
    );
    gender = c.gender ?? "";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final localization = AppLocalizations.of(context)!;
    final picked = await showModalBottomSheet<XFile?>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(localization.takeAPhoto),
                onTap: () async {
                  final photo =
                      await _picker.pickImage(source: ImageSource.camera);
                  Navigator.of(context).pop(photo);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: Text(localization.chooseFromGallery),
                onTap: () async {
                  final photo =
                      await _picker.pickImage(source: ImageSource.gallery);
                  Navigator.of(context).pop(photo);
                },
              ),
              ListTile(
                leading: const Icon(Icons.close),
                title: Text(localization.cancel),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        _avatarFile = File(picked.path);
      });
    }
  }

  void _selectDate() async {
    DateTime initial = selectedDob ?? DateTime(1990);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDob = picked;
        _dobController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      String? dobString;
      if (selectedDob != null) {
        dobString = DateFormat('dd/MM/yyyy').format(selectedDob!);
      } else {
        dobString = null;
      }

      // Save logic here
      final updated = CustomerModel(
        avatar: widget.customer.avatar,
        name: _nameController.text,
        phoneNumber: _phoneController.text,
        email: _emailController.text,
        dob: dobString,
        gender: gender,
        badge: widget.customer.badge,
      );
      Navigator.pop(context, updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final imageWidget = _avatarFile != null
        ? CircleAvatar(
            radius: 48,
            backgroundImage: FileImage(_avatarFile!),
          )
        : (widget.customer.avatar != null
            ? CircleAvatar(
                radius: 48,
                backgroundImage: NetworkImage(widget.customer.avatar!),
              )
            : CircleAvatar(
                radius: 48,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.person, size: 48, color: Colors.white),
              ));

    return Scaffold(
      backgroundColor: const Color(0xFFFDEDF2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: Text(
          localization.customerDetailEdit,
          style:
              TextStyle(color: Color(0xFF660033), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: imageWidget,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade400),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Icon(Icons.camera_alt, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.customer.name ?? "",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(widget.customer.badge ?? ""),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Full name
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: localization.fullname),
              validator: (val) =>
                  val!.isEmpty ? localization.pleaseEnterFullname : null,
            ),
            const SizedBox(height: 12),

            // Phone
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(labelText: localization.phoneNumber),
              validator: (val) =>
                  val!.isEmpty ? localization.pleaseEnterPhoneNumber : null,
            ),
            const SizedBox(height: 12),

            // Email
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (val) {
                if (val!.isEmpty) return localization.pleaseEnterEmail;
                final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                if (!regex.hasMatch(val)) return localization.invalidEmail;
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Date of birth
            TextFormField(
              controller: _dobController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: localization.dateOfBirth,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _selectDate,
                ),
              ),
              validator: (val) =>
                  val!.isEmpty ? localization.pleaseSelectDateOfBirth : null,
            ),
            const SizedBox(height: 12),

            // Gender
            Text(localization.gender, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                localization.male,
                localization.female,
                localization.other
              ].map((g) {
                return Row(
                  children: [
                    Radio<String>(
                      value: g,
                      groupValue: gender,
                      onChanged: (val) => setState(() => gender = val!),
                      activeColor: Colors.pink,
                    ),
                    Text(g),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Save button
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(localization.save, style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 16),

            // Delete button
            Center(
              child: TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeleteCustomerDialog(
                      onDeleteConfirmed: () {
                        // action delete
                      },
                    ),
                  );
                },
                child: Text(
                  localization.deleteCustomer,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
