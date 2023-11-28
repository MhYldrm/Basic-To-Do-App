import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repo/notlar_dao_repository.dart';

class DetaySayfaCubit extends Cubit<void>{

  DetaySayfaCubit():super(0);


  var nrepo = NotlarDaoRepository();

  Future<void> guncelle (int id,String not_ad) async{
    await nrepo.guncelle(id, not_ad);
  }
}