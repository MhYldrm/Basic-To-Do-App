import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/entity/notlar.dart';
import 'package:todo_app/ui/cubit/detay_sayfa_cubit.dart';

class DetaySayfa extends StatefulWidget {
  Notlar not;
  DetaySayfa({required this.not});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfNotKaydi = TextEditingController();


  @override
  void initState() {
    super.initState();
    var not = widget.not;
    tfNotKaydi.text = not.not_ad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Detay Sayfa"),
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
                    controller: tfNotKaydi,decoration: const InputDecoration(hintText: ""),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      context.read<DetaySayfaCubit>().guncelle(widget.not.id, tfNotKaydi.text);
                    },
                    child: Text("GÜNCELLE"),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
