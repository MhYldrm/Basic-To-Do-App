import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/entity/notlar.dart';
import 'package:todo_app/data/repo/notlar_dao_repository.dart';

class AnasayfaCubit extends Cubit<List<Notlar>> {
  AnasayfaCubit():super(<Notlar>[]);

  var nrepo = NotlarDaoRepository();

  Future<void> notlariYukle () async {

    var liste = await nrepo.notlariYukle();
    emit(liste);

  }

  Future<void> ara (String aramaKelimesi) async{
    var liste = await nrepo.ara(aramaKelimesi);
    emit(liste);
  }

  Future<void> sil (int id) async{
    await nrepo.sil(id);
    notlariYukle();
  }

}