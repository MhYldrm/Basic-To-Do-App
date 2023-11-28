import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/ui/cubit/kayit_sayfa_cubit.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfNotKaydi = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Yeni Görev"),
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.only(left: 30,right: 30,top: 160),
          child: SizedBox(
            width: 500,
            height: 200,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              shadowColor: Colors.black87,
              color: Colors.white10,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextField(
                    controller: tfNotKaydi,decoration: const InputDecoration(hintText: "Yeni Görev ?"),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      context.read<KayitSayfaCubit>().kaydet(tfNotKaydi.text);
                    },
                    child: Text("KAYDET"),
                  ),
                ],
              ),
            )
          ),
        ),
      );
  }
}
