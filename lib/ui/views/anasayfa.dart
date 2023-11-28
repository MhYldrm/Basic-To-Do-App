import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/entity/notlar.dart';
import 'package:todo_app/ui/cubit/anasayfa_cubit.dart';
import 'package:todo_app/ui/views/detay_sayfa.dart';
import 'package:todo_app/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;


  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().notlariYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      appBar: AppBar(
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = false;
            });
            context.read<AnasayfaCubit>().notlariYukle();
          }, icon: const Icon(Icons.clear)) :
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu = true;
            });
          }, icon: const Icon(Icons.search)),
        ],
        centerTitle: true,
        title: aramaYapiliyorMu ?
        TextField(
          decoration: const InputDecoration(hintText: "Ara"),
          onChanged: (aramaSonucu){
            context.read<AnasayfaCubit>().ara(aramaSonucu);
          },
        ) :
        const Text("TO DO APP") ,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Container(
          padding: EdgeInsets.all(18),
          child: BlocBuilder<AnasayfaCubit,List<Notlar>>(
            builder: (context,notlarListesi){
              if(notlarListesi.isNotEmpty){
                return ListView.builder(
                  itemCount: notlarListesi.length,
                  itemBuilder: (context,indeks){
                    var not = notlarListesi[indeks];
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(not: not)))
                            .then((value) {
                         context.read<AnasayfaCubit>().notlariYukle();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          color: Colors.yellowAccent.shade400,
                          child: SizedBox(
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(not.not_ad,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                                  const Spacer(),
                                  IconButton(onPressed: (){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("${not.not_ad} görevi silinsin mi?"),
                                        action: SnackBarAction(
                                          label: "Evet",
                                          onPressed: (){
                                           context.read<AnasayfaCubit>().sil(not.id);
                                          },
                                        ),
                                      )
                                    );
                                  }, icon: Icon(Icons.clear,color: Colors.redAccent.shade700)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },

                );
              }else{
                return const Center();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => KayitSayfa()))
              .then((value) {
                context.read<AnasayfaCubit>().notlariYukle();
          });
        },
        child: const Icon(Icons.add_task),
      ),
    );
  }
}
