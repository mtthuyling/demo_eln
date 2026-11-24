import 'package:demo_eln/ingredient_repository.dart';
import 'package:test/test.dart';

// DAO giả, thay cho database thật
class FakeIngredientDao implements IngredientDao {
  final List<Ingredient> data;
  int calls = 0;
  FakeIngredientDao(this.data);

  @override
  Future<List<Ingredient>> findAllIngredients() async {
    calls++;
    return data;
  }
}

void main() {
  group('IngredientRepository', () {
    test('findByRecipe returns only ingredients of that recipe', () async {
      // Arrange
      final dao = FakeIngredientDao(const [
        Ingredient(id: 1, recipeId: 100, name: 'Pasta'),
        Ingredient(id: 2, recipeId: 100, name: 'Garlic'),
        Ingredient(id: 3, recipeId: 200, name: 'Rice'),
      ]);
      final repo = IngredientRepository(dao: dao);

      // Act
      final result = await repo.findByRecipe(100);

      // Assert
      expect(result.length, equals(2));
      expect(result.map((e) => e.name), containsAll(['Pasta', 'Garlic']));
      expect(dao.calls, equals(1));
    });
  });
}