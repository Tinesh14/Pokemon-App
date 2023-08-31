import '../../network/services.dart';
import '../../utils/api.dart';
import '../model/detail_pokemon.dart';

abstract class IDetailRepository {
  Future<DetailDescription> getDescription(int id);
}

class DetailRepository implements IDetailRepository {
  final DioService _dioService;

  DetailRepository(this._dioService);

  @override
  Future<DetailDescription> getDescription(int id) async {
    var result = await _dioService.getDio().get(API.REQUEST_DESCRIPTION(id));

    return DetailDescription.fromJson(result.data);
  }
}
