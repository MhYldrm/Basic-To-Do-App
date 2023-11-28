import 'package:todo_app/data/entity/notlar.dart';
import 'package:todo_app/sqlite/veritabani_yardimcisi.dart';

class NotlarDaoRepository {


  Future<void> kaydet (String not_ad) async{
    var db = await VeritabaniYardimcisi.veriTabaniErisim();
    var yeniNot = Map<String,dynamic>();
    yeniNot["not_ad"] = not_ad;

    await db.insert("notlar", yeniNot);  // insert metoduna ilk parametre veritabanıdaki tablonun adı yazılır, ikincisine yeni nesne

  }

  Future<void> guncelle (int id,String not_ad) async{
    var db = await VeritabaniYardimcisi.veriTabaniErisim();

    var guncellenenNot = Map<String,dynamic>();
    guncellenenNot["not_ad"] = not_ad;

    await db.update("notlar", guncellenenNot,where: "id = ?", whereArgs: [id]);
  }

  Future<List<Notlar>> notlariYukle () async {
    var db = await VeritabaniYardimcisi.veriTabaniErisim();
    List<Map<String,dynamic>> satirlar = await db.rawQuery("SELECT * FROM notlar"); //notlar tablosundakileri getirttik

    return List.generate(satirlar.length, (index){
      var satir = satirlar[index];         // list.generate ile liste üretip, veritabanındakileri buraya aktardık
      var id = satir["id"];                // veritabanındaki id ve not_adı ,, Notlar sınıfındaki id ve not_adına aktardık
      var not_ad = satir["not_ad"];

      return Notlar(id: id, not_ad: not_ad);
    });
  }

  Future<List<Notlar>> ara (String aramaKelimesi) async{
    var db = await VeritabaniYardimcisi.veriTabaniErisim();
    List<Map<String,dynamic>> satirlar = await db.rawQuery("SELECT * FROM notlar WHERE not_ad like '%$aramaKelimesi%'"); //notlar tablosundakileri getirttik ( arama yapma fonksiyonu kodu bu )

    return List.generate(satirlar.length, (index){
      var satir = satirlar[index];         // list.generate ile liste üretip, veritabanındakileri buraya aktardık
      var id = satir["id"];                // veritabanındaki id ve not_adı ,, Notlar sınıfındaki id ve not_adına aktardık
      var not_ad = satir["not_ad"];

      return Notlar(id: id, not_ad: not_ad);
    });
  }

  Future<void> sil (int id) async{
    var db = await VeritabaniYardimcisi.veriTabaniErisim();

    await db.delete("notlar",where: "id = ?",whereArgs: [id]);
  }


}