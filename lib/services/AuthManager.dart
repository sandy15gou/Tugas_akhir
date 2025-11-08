import 'package:shared_preferences/shared_preferences.dart';
import 'User.dart';

class AuthManager {
  static final AuthManager instance = AuthManager._init();
  AuthManager._init();

  // Dummy users untuk demo
  final List<User> _dummyUsers = [
    // Admin
    User(
      id: 1,
      username: 'admin',
      password: 'admin123',
      role: 'admin',
      nama: 'Administrator',
    ),

    // Guru 1 - Matematika
    User(
      id: 2,
      username: 'guru1',
      password: 'guru123',
      role: 'guru',
      nama: 'Siti Nurhaliza',
      nip: '198501012010012001',
    ),

    // Guru 2 - Bahasa Inggris
    User(
      id: 3,
      username: 'guru2',
      password: 'guru123',
      role: 'guru',
      nama: 'Budi Santoso',
      nip: '198605152011012002',
    ),

    // Siswa 1 - Kelas 7A
    User(
      id: 4,
      username: 'siswa7',
      password: 'siswa123',
      role: 'siswa',
      nama: 'Ahmad Fadhil',
      nis: 'NIS-2024007',
      kelas: '7A',
    ),

    // Siswa 2 - Kelas 8A
    User(
      id: 5,
      username: 'siswa8',
      password: 'siswa123',
      role: 'siswa',
      nama: 'Rizki Ramadhan',
      nis: 'NIS-2024008',
      kelas: '8A',
    ),

    // Siswa 3 - Kelas 9A
    User(
      id: 6,
      username: 'siswa9',
      password: 'siswa123',
      role: 'siswa',
      nama: 'Dewi Lestari',
      nis: 'NIS-2024009',
      kelas: '9A',
    ),
  ];

  User? _currentUser;

  User? get currentUser => _currentUser;

  // Method untuk mendapatkan current user
  User? getCurrentUser() {
    return _currentUser;
  }

  bool get isLoggedIn => _currentUser != null;
  bool get isAdmin => _currentUser?.role == 'admin';
  bool get isGuru => _currentUser?.role == 'guru';
  bool get isSiswa => _currentUser?.role == 'siswa';

  // Get tingkat kelas (7, 8, atau 9)
  int? getTingkatKelas() {
    if (_currentUser?.kelas == null) return null;
    final kelas = _currentUser!.kelas!;
    // Extract angka pertama dari string kelas (contoh: "8A" -> 8)
    final match = RegExp(r'^(\d+)').firstMatch(kelas);
    if (match != null) {
      return int.tryParse(match.group(1)!);
    }
    return null;
  }

  // Login
  Future<bool> login(String username, String password) async {
    try {
      final user = _dummyUsers.firstWhere(
        (u) => u.username == username && u.password == password,
        orElse: () => throw Exception('User not found'),
      );

      _currentUser = user;

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('id', user.id ?? 0);
      await prefs.setString('username', user.username);
      await prefs.setString('role', user.role);
      await prefs.setString('nama', user.nama);
      if (user.nis != null) await prefs.setString('nis', user.nis!);
      if (user.nip != null) await prefs.setString('nip', user.nip!);
      if (user.kelas != null) await prefs.setString('kelas', user.kelas!);

      return true;
    } catch (e) {
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    _currentUser = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Check if user is already logged in
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('id');
    final username = prefs.getString('username');
    final role = prefs.getString('role');
    final nama = prefs.getString('nama');

    if (username != null && role != null && nama != null) {
      _currentUser = User(
        id: id,
        username: username,
        password: '',
        role: role,
        nama: nama,
        nis: prefs.getString('nis'),
        nip: prefs.getString('nip'),
        kelas: prefs.getString('kelas'),
      );
      return true;
    }
    return false;
  }

  // Register new user
  Future<bool> register({
    required String username,
    required String password,
    required String role,
    required String nama,
    String? nis,
    String? nip,
    String? kelas,
  }) async {
    try {
      // Check if username already exists
      final exists = _dummyUsers.any((u) => u.username == username);
      if (exists) {
        return false;
      }

      // Generate ID baru
      final newId = _dummyUsers.isEmpty ? 1 : _dummyUsers.map((u) => u.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;

      final newUser = User(
        id: newId,
        username: username,
        password: password,
        role: role,
        nama: nama,
        nis: nis,
        nip: nip,
        kelas: kelas,
      );

      _dummyUsers.add(newUser);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get all users (admin only)
  List<User> getAllUsers() {
    return List.from(_dummyUsers);
  }

  // Update user
  Future<bool> updateUser({
    required String username,
    String? password,
    String? nama,
    String? nis,
    String? nip,
  }) async {
    try {
      final index = _dummyUsers.indexWhere((u) => u.username == username);
      if (index == -1) return false;

      final oldUser = _dummyUsers[index];
      _dummyUsers[index] = User(
        username: username,
        password: password ?? oldUser.password,
        role: oldUser.role,
        nama: nama ?? oldUser.nama,
        nis: nis ?? oldUser.nis,
        nip: nip ?? oldUser.nip,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // Delete user
  Future<bool> deleteUser(String username) async {
    try {
      _dummyUsers.removeWhere((u) => u.username == username);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Check permission
  bool canEdit() {
    return _currentUser?.role == 'admin';
  }

  bool canViewDatabase() {
    return _currentUser?.role == 'admin';
  }
}

