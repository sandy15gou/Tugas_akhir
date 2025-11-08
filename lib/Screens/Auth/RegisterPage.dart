import 'package:flutter/material.dart';
import 'package:tugas_akhir/services/AuthManager.dart';
import 'LoginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _namaController = TextEditingController();
  final _nisController = TextEditingController();
  final _nipController = TextEditingController();

  String _selectedRole = 'siswa';
  String? _selectedKelas;
  final List<String> _kelasList = [
    '7A', '7B', '7C',
    '8A', '8B', '8C',
    '9A', '9B', '9C',
  ];

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _namaController.dispose();
    _nisController.dispose();
    _nipController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password dan konfirmasi password tidak sama'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final success = await AuthManager.instance.register(
      username: _usernameController.text,
      password: _passwordController.text,
      role: _selectedRole,
      nama: _namaController.text,
      nis: _selectedRole == 'siswa' ? _nisController.text : null,
      nip: _selectedRole == 'guru' ? _nipController.text : null,
      kelas: _selectedRole == 'siswa' ? _selectedKelas : null,
    );

    setState(() {
      _isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Registrasi berhasil! Silakan login'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Username sudah digunakan'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF134B70), Color(0xFF508C9B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Logo/Icon
                        Container(
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(0xFF134B70).withAlpha(25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person_add,
                            size: 50,
                            color: Color(0xFF134B70),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Title
                        Text(
                          'Registrasi Akun',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF134B70),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Buat akun baru untuk siswa atau guru',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 24),

                        // Role Selection
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedRole = 'siswa';
                                    });
                                  },
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: _selectedRole == 'siswa'
                                          ? Color(0xFF134B70)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.school,
                                          color: _selectedRole == 'siswa'
                                              ? Colors.white
                                              : Colors.grey,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Siswa',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: _selectedRole == 'siswa'
                                                ? Colors.white
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedRole = 'guru';
                                    });
                                  },
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      color: _selectedRole == 'guru'
                                          ? Color(0xFF134B70)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        bottomRight: Radius.circular(12),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: _selectedRole == 'guru'
                                              ? Colors.white
                                              : Colors.grey,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Guru',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: _selectedRole == 'guru'
                                                ? Colors.white
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),

                        // Nama Lengkap
                        TextFormField(
                          controller: _namaController,
                          decoration: InputDecoration(
                            labelText: 'Nama Lengkap',
                            prefixIcon: Icon(Icons.person_outline),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan nama lengkap';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),

                        // NIS (untuk siswa) atau NIP (untuk guru)
                        if (_selectedRole == 'siswa')
                          TextFormField(
                            controller: _nisController,
                            decoration: InputDecoration(
                              labelText: 'NIS (Nomor Induk Siswa)',
                              prefixIcon: Icon(Icons.badge_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Contoh: NIS-2024001',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan NIS';
                              }
                              return null;
                            },
                          ),
                        if (_selectedRole == 'siswa')
                          SizedBox(height: 16),

                        // Dropdown Kelas (untuk siswa)
                        if (_selectedRole == 'siswa')
                          DropdownButtonFormField<String>(
                            value: _selectedKelas,
                            decoration: InputDecoration(
                              labelText: 'Kelas',
                              prefixIcon: Icon(Icons.class_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Pilih kelas',
                            ),
                            items: _kelasList.map((kelas) {
                              return DropdownMenuItem(
                                value: kelas,
                                child: Text(kelas),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedKelas = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Pilih kelas';
                              }
                              return null;
                            },
                          ),
                        if (_selectedRole == 'guru')
                          TextFormField(
                            controller: _nipController,
                            decoration: InputDecoration(
                              labelText: 'NIP (Nomor Induk Pegawai)',
                              prefixIcon: Icon(Icons.badge_outlined),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              hintText: 'Contoh: 198501012010012001',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Masukkan NIP';
                              }
                              return null;
                            },
                          ),
                        SizedBox(height: 16),

                        // Username
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan username';
                            }
                            if (value.length < 4) {
                              return 'Username minimal 4 karakter';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),

                        // Password
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Masukkan password';
                            }
                            if (value.length < 6) {
                              return 'Password minimal 6 karakter';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),

                        // Confirm Password
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureConfirmPassword,
                          decoration: InputDecoration(
                            labelText: 'Konfirmasi Password',
                            prefixIcon: Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Konfirmasi password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24),

                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF134B70),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'DAFTAR',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 16),

                        // Login Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sudah punya akun? ',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Login di sini',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF134B70),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

