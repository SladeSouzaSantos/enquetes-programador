import 'package:enquetes_programadores/domain/entities/entities.dart';
import 'package:enquetes_programadores/domain/usecases/usecases.dart';
import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount{
  final SaveSecureCacheStorage saveCacheStorage;

  LocalSaveCurrentAccount({@required this.saveCacheStorage});

  Future<void> save(AccountEntity account) async{
    await saveCacheStorage.saveSecure(key: "token", value: account.token);
  }
}

abstract class SaveSecureCacheStorage{
  Future<void> saveSecure({@required String key, @required String value});
}

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage{}

void main() {
  test("Should call SaveCacheStorage with correct values", () async{
    final saveCacheStorage = SaveSecureCacheStorageSpy();
    final sut = LocalSaveCurrentAccount(saveCacheStorage: saveCacheStorage);
    final account = AccountEntity(faker.guid.guid());

    await sut.save(account);

    verify(saveCacheStorage.saveSecure(key: "token", value: account.token));
  });
}
