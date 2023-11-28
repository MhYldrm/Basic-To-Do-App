import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniYardimcisi {

  static final String veritabaniAdi = "rehber.sqlite";

  static Future<Database> veriTabaniErisim () async {
    String veritabaniYolu = join(await getDatabasesPath(),veritabaniAdi); // yukarıdaki yolda veritabanına ulaştık

    if(await databaseExists(veritabaniYolu)){           // eğer bu yolda veri tabanı varsa if çalışacak ( veritabanı kopyalama)
      print("Veri tabanı daha önce kopyalanmış");
    }else{
      ByteData data = await rootBundle.load("veritabani/$veritabaniAdi");  // veritabanına eriştik böylece
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes); // byte dönüştürdük
      await File(veritabaniYolu).writeAsBytes(bytes,flush: true);  // veritabanını kopyaldık
      print("Veritabanı kopyalandı");
    }

    return openDatabase(veritabaniYolu);
  }

}