import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/user_entity.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';

class UserFormPage extends StatefulWidget {
  final UserEntity? user;
  const UserFormPage({super.key, this.user});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _noTelponController = TextEditingController();
  final _alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      _nameController.text = widget.user!.name;
      _emailController.text = widget.user!.email;
      _noTelponController.text = widget.user!.noTelpon;
      _alamatController.text = widget.user!.alamat;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.user != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? "Edit User" : "Tambah User")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nama Lengkap", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Email tidak boleh kosong' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _noTelponController,
                decoration: const InputDecoration(labelText: "No Telpon (+62)", border: OutlineInputBorder()),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Nomor telepon tidak boleh kosong';
                  if (!value.startsWith('+62')) return 'Format harus diawali +62';
                  if (value.length > 15) return 'Maksimal 15 karakter';
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(labelText: "Alamat", border: OutlineInputBorder()),
                maxLines: 3,
                validator: (value) => value!.isEmpty ? 'Alamat tidak boleh kosong' : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newUser = UserEntity(
                        id: isEdit ? widget.user!.id : DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _nameController.text,
                        email: _emailController.text,
                        noTelpon: _noTelponController.text,
                        alamat: _alamatController.text,
                      );

                      if (isEdit) {
                        context.read<UserBloc>().add(UpdateUserEvent(newUser));
                      } else {
                        context.read<UserBloc>().add(AddUserEvent(newUser));
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(isEdit ? "Simpan Perubahan" : "Simpan User Baru"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}