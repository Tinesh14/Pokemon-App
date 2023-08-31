import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/modules/detail/cubit/detail_state.dart';
import 'package:poke_app/modules/detail/repository/detail_repository.dart';

class DetailCubit extends Cubit<DetailState> {
  final IDetailRepository detailRepository;
  int id;
  DetailCubit(this.detailRepository, this.id) : super(DetailLoading()) {
    load();
  }
  load() async {
    try {
      var data = await detailRepository.getDescription(id);
      emit(DetailSuccess(data));
    } catch (e) {}
  }
}
