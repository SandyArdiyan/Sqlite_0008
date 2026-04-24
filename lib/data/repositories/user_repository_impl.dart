import '../../domain/entities/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../../helper/database_helper.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final DatabaseHelper dbHelper;

  UserRepositoryImpl(this.dbHelper);

  @override
  Future<void> addUser(UserEntity user) async {
    final db = await dbHelper.database;
    final userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      noTelpon: user.noTelpon,
      alamat: user.alamat,
    );
    await db.insert('users', userModel.toMap());
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final db = await dbHelper.database;
    final userModel = UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      noTelpon: user.noTelpon,
      alamat: user.alamat,
    );
    await db.update(
      'users',
      userModel.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  @override
  Future<void> deleteUser(String id) async {
    final db = await dbHelper.database;
    await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // Ubah nama metode dari getUsers menjadi getAllUsers sesuai pesan error
  @override
  Future<List<UserEntity>> getAllUsers() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return UserModel.fromMap(maps[i]);
    });
  }
}