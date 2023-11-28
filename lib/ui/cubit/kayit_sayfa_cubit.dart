import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repo/notlar_dao_repository.dart';

class KayitSayfaCubit  extends Cubit<void>{
  KayitSayfaCubit():super (0);


  var nrepo = NotlarDaoRepository();

  Future<void> kaydet (String not_ad) async{
   await nrepo.kaydet(not_ad);
  }

}