class Ingredient {
  final int id;
  final int recipeId;
  final String name;
  const Ingredient({required this.id, required this.recipeId, required this.name});
}
// DAO là Data Access Object(đối tượng truy cập dữ liệu)
abstract class IngredientDao {
  Future<List<Ingredient>> findAllIngredients();
}

class IngredientRepository {
  // Phụ thuộc truyền qua constructor => dễ thay bằng đối tượng giả khi test
  final IngredientDao dao;
  IngredientRepository({required this.dao});

  Future<List<Ingredient>> findByRecipe(int recipeId) async {
    final all = await dao.findAllIngredients();
    return all.where((e) => e.recipeId == recipeId).toList();
  }
}